//
//  Interactor.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 2.03.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import UIKit
//Object
//protocol
//Reference to presenter

//MARK: Protocol
protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getNotes()
}

class UserNotesInteractor: AnyInteractor {
    //MARK: Properties
    var presenter: AnyPresenter?
    
    private let db = Firestore.firestore()
    
    var notes : [UserNotes] = []
    
    //MARK: Method
    func getNotes() {
        guard let userId = Auth.auth().currentUser?.uid  else {
            DispatchQueue.main.async {
                self.presenter?.userNotLogin()
            }
            return
        }
        
        db.collection("Users").document(userId).collection("Notes").getDocuments() { data, error in
            guard let data = data,
                  error == nil else {
                self.presenter?.interactorDidFetch(with: .failure(error!))
                return
            }
            do {
                self.notes.removeAll()
                data.documents.forEach { note in
                    if let not = note["note"] as? [[String: Any]],
                       let documentId = note.documentID as? String,
                       let date = note["date"] as? String,
                       let type = note["type"] as? String{
                        let notee = UserNotes(note: not,
                                              documentId: documentId,
                                              date: date, type: type)
                        self.notes.append(notee)
                    }
                }
                DispatchQueue.main.async {
                    self.presenter?.interactorDidFetch(with: .success(self.notes))
                }
                
            }catch{
                DispatchQueue.main.async {
                    self.presenter?.interactorDidFetch(with: .failure(error))
                }
                
            }
        }
    }
    
}
