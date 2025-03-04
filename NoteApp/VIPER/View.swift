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

//MARK: Protocol
protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func updateNotes(with notes: [UserNotes])
    func updateNotes(with error: String)
}

class UserNotesViewController: UIViewController, AnyView, openNote{
    
    //MARK: Properties
    var presenter: (any AnyPresenter)?
    
    var notes: [UserNotes] = []
    
    var items: [String] = ["All", "Task", "Notes", "Events"]
    
    var string: String = ""
    
    var buttons: [UIButton] = []
    
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
        stackview.isHidden = true
        return stackview
    }()
    
    private let stackView4: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.backgroundColor = .red
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
        stackview.backgroundColor = .brown
        return stackview
    }()
    
    private let welcomeLabel : UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(named: "LightGray")
        return label
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.backgroundColor = .cyan
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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = .white
        return activity
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
    
    private let calendarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "calendar")!.withTintColor(.black),
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
        activityIndicator.startAnimating()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeButton.layer.cornerRadius = (homeButton.frame.size.width) / 2
        addButton.layer.cornerRadius = (addButton.frame.size.width ) / 2
        calendarButton.layer.cornerRadius = (calendarButton.frame.size.width ) / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeButton.backgroundColor = UIColor(named: "Orange")
        homeButton.setImage(UIImage(named: "house")?.withTintColor(.white),
                            for: .normal)
        addButton.backgroundColor  = UIColor(named: "Gray")
        calendarButton.backgroundColor = UIColor(named: "Gray")
        addButton.setImage(UIImage(named: "plus")?.withTintColor(.black),
                           for: .normal)
        calendarButton.setImage(UIImage(named: "calendar")?.withTintColor(.black),
                                for: .normal)
        notesCollectionView.reloadData()
    }
    
    //MARK: Setup Methods
    func setupViews(){
        
        view.backgroundColor = .black
        view.addSubview(activityIndicator)
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(stackView4)
        stackView4.addArrangedSubview(imageView)
        stackView4.addArrangedSubview(stackView5)
        stackView5.addArrangedSubview(welcomeLabel)
        stackView5.addArrangedSubview(nameLabel)
        
        stackView.addArrangedSubview(label2)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: "CollectionViewCell")
        stackView.addArrangedSubview(collectionView)
        
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
        stackView2.addArrangedSubview(calendarButton)
        buttons.append(calendarButton)
    }
    
    func setupConstraints(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.height.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        stackView4.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.width.equalTo(90)
        }
        stackView5.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        welcomeLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        label2.snp.makeConstraints { make in
            make.height.equalTo(160)
        }
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalToSuperview()
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
        calendarButton.snp.makeConstraints { make in
            make.width.height.equalTo(70)
        }
    }
    
    //MARK: Functions
    func updateNotes(with notes: [UserNotes]) {
        DispatchQueue.main.async {
            self.notes = notes
            self.notesCollectionView.reloadData()
            self.stackView.isHidden = false
            self.notesCollectionView.snp.updateConstraints { make in
                make.height.equalTo(self.notesCollectionView.collectionViewLayout.collectionViewContentSize.height)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    
    func updateNotes(with error: String) {
        print(error)
    }
    
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
                    let calendarVC = CalendarVC()
                    calendarVC.modalPresentationStyle = .fullScreen
                    calendarVC.isModalInPresentation = true
                    present(calendarVC, animated: true)
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
}

//MARK: Delegates
extension UserNotesViewController: UICollectionViewDelegate,
                                   UICollectionViewDataSource,
                                   UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return items.count
        }else {
            return notes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell",
                                                          for: indexPath) as! CollectionViewCell
            if items[indexPath.row] == "All" {
                cell.button.setTitleColor(.black,
                                          for: .normal)
                cell.button.backgroundColor = .white
            }
            cell.button.setTitle(items[indexPath.row],
                                 for: .normal)
            return cell
        }else {
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
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.notesCollectionView {
            let width = collectionView.frame.width
            return CGSize(width: width, height: 250)
        }else {
            let height = collectionView.frame.height
            return CGSize(width: 90, height: height)
        }
    }
}
