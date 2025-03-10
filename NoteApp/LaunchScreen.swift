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
//View Controller
//Protocol
//Reference to presenter

//MARK: Protocol
protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func updateNotes(with notes: [UserNotes])
    func updateNotes(with error: String)
    func userNotLogin()
}

class LaunchScreen: UIViewController, AnyView {
    
    //MARK: Properties
    var presenter: AnyPresenter?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.interactor?.getNotes()
    }
    
    //MARK: Setup Methods
    func setupViews(){
        view.backgroundColor = .black
        
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints(){
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    //MARK: Functions
    func updateNotes(with notes: [UserNotes]) {
        DispatchQueue.main.async {
            guard let user = Auth.auth().currentUser else {
                self.userNotLogin()
                return
            }
            
            let vc = UserNotesViewController()
            vc.userId = user.uid
            
            Task {
                do {
                    let document = try await self.db.collection("Users").document(user.uid).getDocument()
                    if let username = document.data()?["userName"] as? String {
                        DispatchQueue.main.async {
                            vc.userName = username
                            vc.nameLabel.text = username
                            vc.notes = notes
                            vc.notesCollectionView.reloadData()
                            self.activityIndicator.stopAnimating()
                            vc.modalPresentationStyle = .fullScreen
                            vc.isModalInPresentation = true
                            self.present(vc, animated: true)
                        }
                    }
                    
                    
                } catch {
                    print("Firestore Kullanıcı Adı Çekme Hatası: \(error.localizedDescription)")
                    self.userNotLogin()
                }
            }
        }
    }
    
    func updateNotes(with error: String) {
        print(error)
        userNotLogin()
    }
    
    func userNotLogin() {
        DispatchQueue.main.async {
            let loginVc = LoginVC()
            loginVc.backButton.isHidden = true
            loginVc.isModalInPresentation = true
            loginVc.modalPresentationStyle = .fullScreen
            self.present(loginVc, animated: true)
        }
        
    }
    
}
