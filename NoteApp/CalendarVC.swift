//
//  CalendarVC.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 4.03.2025.
//

import UIKit
import SnapKit

class CalendarVC: UIViewController {

    //MARK: UI Elements
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"),
                        for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "DarkGray3")
        button.addTarget(self, action: #selector(dismissVC(_:)),
                         for: .touchUpInside)
        return button
    }()
    
    private let monthButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "calendar")?.withTintColor(.white),
                        for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "DarkGray3")
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.imageEdgeInsets.right = 12
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Task Schedule"
        return label
    }()
    
    private let calendarCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 40,
                                 height: 40)
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = UIColor(named: "DarkGray3")
        collection.layer.cornerRadius = 20
        return collection
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        // Do any additional setup after loading the view.
    }

    //MARK: Setup Methods
    func setupViews(){
        view.backgroundColor = .black
        backButton.layer.cornerRadius = 25
        view.addSubview(backButton)
        monthButton.layer.cornerRadius = 25
        let date = DateFormatter()
        date.dateFormat = "MMMM"
        monthButton.setTitle(date.string(from: Date()),
                             for: .normal)
        view.addSubview(monthButton)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(label)
        calendarCollection.delegate = self
        calendarCollection.dataSource = self
        stackView.addArrangedSubview(calendarCollection)
    }

    func setupConstraints(){
        backButton.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.width.equalTo(50)
        }
        monthButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
            make.width.equalTo(120)
        }
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
        stackView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(scrollView.contentLayoutGuide)
        }
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        calendarCollection.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(400)
        }
    }
    
    @objc func dismissVC(_ sender: UIButton){
        dismiss(animated: true)
    }
}

//MARK: Delegates
extension CalendarVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
    
    
}
