//
//  View.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 2.03.2025.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth

class UserNotesViewController: UIViewController, openNote{
    
    //MARK: Properties
    var notes: [UserNotes] = []
    
    var items: [String] = ["All", "Task", "Notes", "Events"]
    
    var string: String = ""
    
    var userName : String = ""
    
    var userId: String = ""
    
    var buttons: [UIButton] = []
    
    var menus: [UIButton] = []
    
    //MARK: UI Elements
    private let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = false
        return scrollview
    }()
    
    private let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 20
        return stackview
    }()
    
    private let stackView4: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        return stackview
    }()
    
    private let stackView5: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        return stackview
    }()
    
    private let welcomeLabel : UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(named: "LightGray")
        return label
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "iphone.and.arrow.right.outward")?.withTintColor(.white), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor(named: "Orange")
        button.addTarget(self, action: #selector(logOutBtn(_:)), for: .touchUpInside)
        button.isHidden = false
        return button
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.text = "All Scheduled for Today"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 60)
        label.numberOfLines = 2
        return label
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let stackView3: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    let notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private let view2: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        return view
    }()
    
    private let stackView2: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 5
        return stackview
    }()
    
    private let homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "house")!.withTintColor(.white),
                        for: .normal)
        button.backgroundColor = UIColor(named: "Orange")
        button.clipsToBounds = true
        button.addTarget(self,
                         action: #selector(buttonAction),
                         for: .touchUpInside)
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus")!.withTintColor(.black),
                        for: .normal)
        button.backgroundColor = UIColor(named: "Gray")
        button.clipsToBounds = true
        button.addTarget(self,
                         action: #selector(buttonAction),
                         for: .touchUpInside)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "login")!.withTintColor(.black),
                        for: .normal)
        button.backgroundColor = UIColor(named: "Gray")
        button.clipsToBounds = true
        button.addTarget(self,
                         action: #selector(buttonAction),
                         for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeButton.layer.cornerRadius = (homeButton.frame.size.width) / 2
        addButton.layer.cornerRadius = (addButton.frame.size.width ) / 2
        loginButton.layer.cornerRadius = (loginButton.frame.size.width ) / 2
        notesCollectionView.snp.updateConstraints { make in
            make.height.equalTo(notesCollectionView.collectionViewLayout.collectionViewContentSize.height)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeButton.backgroundColor = UIColor(named: "Orange")
        homeButton.setImage(UIImage(named: "house")?.withTintColor(.white),
                            for: .normal)
        addButton.backgroundColor  = UIColor(named: "Gray")
        loginButton.backgroundColor = UIColor(named: "Gray")
        addButton.setImage(UIImage(named: "plus")?.withTintColor(.black),
                           for: .normal)
        loginButton.setImage(UIImage(named: "login")?.withTintColor(.black),
                                for: .normal)
        nameLabel.text = userName
        notesCollectionView.reloadData()
    }
    
    //MARK: Setup Methods
    func setupViews(){
        
        view.backgroundColor = .black
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(stackView4)
        stackView4.addArrangedSubview(stackView5)
        stackView5.addArrangedSubview(welcomeLabel)
        stackView5.addArrangedSubview(nameLabel)
        stackView4.addArrangedSubview(logoutButton)
        
        stackView.addArrangedSubview(label2)
        
        stackView.addArrangedSubview(stackView3)
        var count = 0
        for i in items {
            let button = UIButton()
            button.tag = count
            button.setTitle(i,
                            for: .normal)
            if i == "All"{
                button.setTitleColor(.black,
                                     for: .normal)
                button.backgroundColor = .white
            }else {
                button.setTitleColor(UIColor(named: "LightGray"),
                                     for: .normal)
                button.backgroundColor = UIColor(named: "DarkGray2")
            }
            button.layer.cornerRadius = 30
            button.addTarget(self, action: #selector(changeColor(_:)),
                             for: .touchUpInside)
            menus.append(button)
            stackView3.addArrangedSubview(button)
            button.snp.makeConstraints { make in
                make.height.equalTo(60)
                make.width.equalTo(100)
            }
            count += 1
        }
        
        label.text = "All"
        stackView.addArrangedSubview(label)

        notesCollectionView.delegate = self
        notesCollectionView.dataSource = self
        notesCollectionView.register(NotesCollectionViewCell.self,
                                     forCellWithReuseIdentifier: "NotesCollectionViewCell")
        stackView.addArrangedSubview(notesCollectionView)
        
        view.addSubview(view2)
        
        view2.addSubview(stackView2)
        stackView2.addArrangedSubview(homeButton)
        buttons.append(homeButton)
        stackView2.addArrangedSubview(addButton)
        buttons.append(addButton)
        if userId != "" {
            loginButton.isHidden = true
        }else {
            loginButton.isHidden = false
        }
        stackView2.addArrangedSubview(loginButton)
        buttons.append(loginButton)
    }
    
    func setupConstraints(){
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        stackView.snp.makeConstraints { make in
            make.height.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        stackView4.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalToSuperview()
        }
        stackView5.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        welcomeLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.top.leading.equalToSuperview().inset(5)
            
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.bottom.leading.equalToSuperview().inset(5)
        }
        logoutButton.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        label2.snp.makeConstraints { make in
            make.height.equalTo(160)
        }
        stackView3.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        label.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        notesCollectionView.snp.makeConstraints { make in
            make.height.equalTo(1000)
        }

        if userId != "" {
            view2.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide)
                make.height.equalTo(80)
                make.width.equalTo(155)
                make.centerX.equalToSuperview()
            }
            stackView2.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(5)
            }
            homeButton.snp.makeConstraints { make in
                make.width.height.equalTo(70)
            }
            addButton.snp.makeConstraints { make in
                make.width.height.equalTo(70)
            }
            loginButton.snp.makeConstraints { make in
                make.width.height.equalTo(0)
            }
        }else {
            view2.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide)
                make.height.equalTo(80)
                make.width.equalTo(230)
                make.centerX.equalToSuperview()
            }
            stackView2.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(5)
            }
            homeButton.snp.makeConstraints { make in
                make.width.height.equalTo(70)
            }
            addButton.snp.makeConstraints { make in
                make.width.height.equalTo(70)
            }
            loginButton.snp.makeConstraints { make in
                make.width.height.equalTo(70)
            }
            logoutButton.isHidden = true
        }
        

    }
    
    //MARK: Functions
    func openNote(note: String, documentId: String) {
        let addVC = AddVC()
        addVC.isModalInPresentation = true
        addVC.modalPresentationStyle = .fullScreen
        addVC.note = note
        addVC.documentId = documentId
        addVC.userId = userId
        present(addVC, animated: true)
    }
    
    //MARK: Actions
    @objc func buttonAction(_ sender: UIButton){
        for button in buttons {
            if button == sender {
                button.backgroundColor = UIColor(named: "Orange")
                button.setImage(button.currentImage?.withTintColor(.white),
                                for: .normal)
                switch button {
                case buttons[0]:
                    print("")
                case buttons[1]:
                    let addVC = AddVC()
                    addVC.userId = userId
                    addVC.modalPresentationStyle = .fullScreen
                    addVC.isModalInPresentation = true
                    present(addVC, animated: true)
                case buttons[2]:
                    if userId == "" {
                        let loginVC = LoginVC()
                        loginVC.modalPresentationStyle = .fullScreen
                        loginVC.isModalInPresentation = true
                        present(loginVC, animated: true)
                    }
                default:
                    return
                }
                
            } else {
                button.backgroundColor = UIColor(named: "Gray")
                button.setImage(button.currentImage?.withTintColor(.black),
                                for: .normal)
            }
        }
    }
    
    @objc func changeColor(_ sender: UIButton){
        for button in menus {
            if sender == button{
                button.backgroundColor = .white
                button.setTitle(items[sender.tag], for: .normal)
                button.setTitleColor(.black, for: .normal)
                label.text = items[sender.tag]
            }
            else {
                button.backgroundColor = UIColor(named: "DarkGray2")
                button.setTitle(items[button.tag], for: .normal)
                button.setTitleColor(UIColor(named: "LightGray"), for: .normal)
            }
        }
        
    }
    
    @objc func logOutBtn(_ sender: UIButton){
        Task {
            try Auth.auth().signOut()
            let router = UserNotesRouter.start()  // Router'ı başlat
            let initialVC = router.entry  // Giriş ekranı veya ana ekranı
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = initialVC
                window.makeKeyAndVisible()
            }
        }
    }
}

//MARK: Delegates
extension UserNotesViewController: UICollectionViewDelegate,
                                   UICollectionViewDataSource,
                                   UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotesCollectionViewCell",
                                                      for: indexPath) as! NotesCollectionViewCell
        let not = notes[indexPath.row].note
        let documentId = notes[indexPath.row].documentId
        cell.layer.cornerRadius = 25
        cell.noteLabel.text = not
        cell.dateLabel.text = notes[indexPath.row].date
        cell.note = not
        cell.documentId = documentId
        cell.delegate = self
        cell.clipsToBounds = true
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 220)
        
    }
}
