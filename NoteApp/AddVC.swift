//
//  AddVC.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 4.03.2025.
//

import UIKit
import SnapKit
import FirebaseFirestore

class AddVC: UIViewController {

    //MARK: Properties
    private let db = Firestore.firestore()
    var note: String = ""
    var documentId: String = ""
    
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
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"),
                        for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "DarkGray3")
        button.addTarget(self, action: #selector(saveNote(_:)),
                         for: .touchUpInside)
        button.isEnabled = false
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
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.textColor = UIColor(named: "LightGray")
        return label
    }()
    
    let text: UITextField = {
        let text = UITextField()
        text.textColor = .white
        text.font = .systemFont(ofSize: 15)
        text.contentVerticalAlignment = .top
        text.addTarget(self,
                       action: #selector(checkForChanges(_:)),
                       for: .allEditingEvents)
        return text
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    //MARK: Setup Methods
    func setupViews(){
        view.backgroundColor = .black
        backButton.layer.cornerRadius = 25
        view.addSubview(backButton)
        doneButton.layer.cornerRadius = 25
        view.addSubview(doneButton)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        let date = DateFormatter()
        date.dateFormat = "dd/MM/yyyy HH:mm"
        dateLabel.text = date.string(from: Date())
        stackView.addArrangedSubview(dateLabel)
        if note != "" {
            text.text = note
        }
        stackView.addArrangedSubview(text)
    }

    func setupConstraints(){
        backButton.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.width.equalTo(50)
        }
        doneButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.width.equalTo(50)
        }
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(70)
        }
        stackView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(scrollView.contentLayoutGuide)
        }
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        text.snp.makeConstraints { make in
            make.height.equalTo(500)
        }
    }
    
    //MARK: Actions
    @objc func dismissVC(_ sender: UIButton){
        dismiss(animated: true)
    }
    
    @objc func saveNote(_ sender: UIButton){
        guard let note = text.text else { return }
        if note != "", documentId != "" {
            Task {
                do {
                    try await db.collection("Notes").document(documentId).setData(["note": note])
                    dismiss(animated: true)
                }catch{
                    print(error)
                }
            }
        }else {
            Task {
                do {
                    try await db.collection("Notes").document().setData(["note": note])
                    dismiss(animated: true)
                }catch{
                    print(error)
                }
            }
        }
    }
    
    @objc func checkForChanges(_ sender: UITextField){
        guard let not = sender.text else { return }
        if note != "" {
            if note != not {
                doneButton.isEnabled = true
            }else {
                doneButton.isEnabled = false
            }
        }else {
            if not != "" {
                doneButton.isEnabled = true
            } else {
                doneButton.isEnabled = false
            }
        }
    }
}
