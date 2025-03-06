//
//  View.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 2.03.2025.
//

import Foundation
import UIKit
import SnapKit
//View Controller
//Protocol
//Reference to presenter

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
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .blue
        return image
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
        stackView4.addArrangedSubview(imageView)
        stackView4.addArrangedSubview(stackView5)
        stackView5.addArrangedSubview(welcomeLabel)
        stackView5.addArrangedSubview(nameLabel)
        
        stackView.addArrangedSubview(label2)
        
        stackView.addArrangedSubview(stackView3)
        
        var count = 0
        for i in items {
            let button = UIButton()
            button.tag = count
            button.setTitle(i, for: .normal)
            if i == "All"{
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = .white
            }else {
                button.setTitleColor(UIColor(named: "LightGray"), for: .normal)
                button.backgroundColor = UIColor(named: "DarkGray2")
            }
            button.layer.cornerRadius = 30
            button.addTarget(self, action: #selector(changeColor(_:)), for: .touchUpInside)
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
        imageView.snp.makeConstraints { make in
            make.width.equalTo(60)
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
    }
    
    //MARK: Functions
    func openNote(note: String, documentId: String) {
        let addVC = AddVC()
        addVC.isModalInPresentation = true
        addVC.modalPresentationStyle = .fullScreen
        addVC.note = note
        addVC.documentId = documentId
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
                    addVC.modalPresentationStyle = .fullScreen
                    addVC.isModalInPresentation = true
                    present(addVC, animated: true)
                case buttons[2]:
                    if userId != "" {
                        let profileVC = ProfileVC()
                        profileVC.isModalInPresentation = true
                        profileVC.modalPresentationStyle = .fullScreen
                        present(profileVC, animated: true)
                    }
                    let loginVC = LoginVC()
                    loginVC.modalPresentationStyle = .fullScreen
                    loginVC.isModalInPresentation = true
                    present(loginVC, animated: true)
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
        return CGSize(width: width, height: 250)
        
    }
}
