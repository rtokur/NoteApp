//
//  LaunchScreen.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 6.03.2025.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore

//MARK: Protocol
protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func updateNotes(with notes: [UserNotes])
    func updateNotes(with error: String)
}

class LaunchScreen: UIViewController, AnyView {
    //MARK: Properties
    var presenter: (any AnyPresenter)?

    let db = Firestore.firestore()
    
    //MARK: UI Elements
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = .white
        return activity
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        setupViews()
        setupConstraints()
    }

    //MARK: Functions
    func updateNotes(with notes: [UserNotes]) {
        DispatchQueue.main.async {
            let vc = UserNotesViewController()
            if let user = Auth.auth().currentUser {
                vc.userId = user.uid
                Task {
                    let document = try await self.db.collection("Users").document(user.uid).getDocument()
                    let username = document.data()?["userName"] as! String
                    print(username)
                    vc.userName = username
                    vc.nameLabel.text = username
                }
                
            }
            vc.notes = notes
            vc.notesCollectionView.reloadData()
            self.activityIndicator.stopAnimating()
            vc.modalPresentationStyle = .fullScreen
            vc.isModalInPresentation = true
            self.present(vc, animated: true)
        }
    }
    
    func updateNotes(with error: String) {
        print(error)
    }
    
    func setupViews(){
        view.backgroundColor = .black
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints(){
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
