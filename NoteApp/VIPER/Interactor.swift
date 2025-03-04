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
        Task {
            try await db.collection("Notes").getDocuments() { data, error in
                guard let data = data,
                      error == nil else {
                    self.presenter?.interactorDidFetch(with: .failure(error!))
                    return
                }
                do {
                    self.notes.removeAll()
                    data.documents.forEach { note in
                        if let not = note["note"] as? String,
                            let documentId = note.documentID as? String{
                            let notee = UserNotes(note: not,
                                                  documentId: documentId)
                            self.notes.append(notee)
                        }
                    }
                    self.presenter?.interactorDidFetch(with: .success(self.notes))
                }catch{
                    self.presenter?.interactorDidFetch(with: .failure(error))
                }
            }
            
        }
    }
    
    
}
