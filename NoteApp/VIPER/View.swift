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

class UserNotesViewController: UIViewController, AnyView {
    //MARK: Properties
    var presenter: (any AnyPresenter)?
    
    var notes: [UserNotes] = []
    
    func updateNotes(with notes: [UserNotes]) {
        DispatchQueue.main.async {
            self.notes = notes
            self.notesCollectionView.reloadData()
            self.stackView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func updateNotes(with error: String) {
        print(error)
    }
    
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
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private let notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.backgroundColor = .clear
        return collection
    }()
    
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
    
    //MARK: Setup Methods
    func setupViews(){
        
        view.backgroundColor = .black
        view.addSubview(activityIndicator)
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(label)
        
        notesCollectionView.delegate = self
        notesCollectionView.dataSource = self
        notesCollectionView.register(NotesCollectionViewCell.self,
                                     forCellWithReuseIdentifier: "NotesCollectionViewCell")
        stackView.addArrangedSubview(notesCollectionView)
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
        label.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        notesCollectionView.snp.makeConstraints { make in
            make.height.equalTo(500)
        }
    }
}
//MARK: Delegates
extension UserNotesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotesCollectionViewCell",
                                                      for: indexPath) as! NotesCollectionViewCell
        cell.label.text = notes[indexPath.row].note
        cell.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.width.equalToSuperview()
        }
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        return cell
    }
    
}
