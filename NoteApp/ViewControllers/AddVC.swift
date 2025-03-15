//
//  AddVC.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 4.03.2025.
//

import UIKit
import SnapKit
import FirebaseFirestore

class AddVC: UIViewController, ChangeStyle, UITextViewDelegate {

    //MARK: Properties
    private let db = Firestore.firestore()
    var note: NSAttributedString?
    var documentId: String = ""
    var userId: String = ""
    var type: String = ""
    
    //MARK: UI Elements
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"),
                        for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor(named: "DarkGray3")
        button.addTarget(self,
                         action: #selector(dismissVC(_:)),
                         for: .touchUpInside)
        return button
    }()
    
    let typeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor(named: "Orange")
        return button
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "line.3.horizontal"),
                        for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "DarkGray3")
        button.addTarget(self,
                         action: #selector(openBar(_:)),
                         for: .touchUpInside)
        button.layer.cornerRadius = 25
        return button
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"),
                        for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "DarkGray3")
        button.addTarget(self,
                         action: #selector(saveNote(_:)),
                         for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.isEnabled = false
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash.fill"),
                        for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "DarkGray3")
        button.addTarget(self,
                         action: #selector(saveNote(_:)),
                         for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.isHidden = true
        button.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
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
    
    var text: UITextView = {
        let text = UITextView()
        text.textColor = .white
        text.font = .systemFont(ofSize: 15)
        text.backgroundColor = .clear
        return text
    }()
    
    private let vieww: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DarkGray3")
        return view
    }()
    
    private let stackView2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private let textButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "text"),
                        for: .normal)
        button.tintColor = .white
        button.addTarget(self,
                         action: #selector(textButtonAction(_:)),
                         for: .touchUpInside)
        return button
    }()
    
    private let listButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bulletpoint"),
                        for: .normal)
        button.tintColor = .white
        button.addTarget(self,
                         action: #selector(listButtonAction(_:)),
                         for: .touchUpInside)
        return button
    }()

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupKeyboard()
    }
    
    //MARK: Setup Methods
    func setupViews(){
        view.backgroundColor = .black

        view.addSubview(backButton)
        let options = ["Notes","Tasks"]
        var menuChildren: [UIMenuElement] = []
        for option in options {
            if type != "" {
                let state: UIMenuElement.State = (option == type) ? .on : .off
                menuChildren.append(UIAction(title: option,
                                             state: state,
                                             handler: { action in
                    
                }))
            }else{
                menuChildren.append(UIAction(title: option,
                                             handler: { [weak self] action in
                    if action.title == "Tasks"{
                        self?.text.attributedText = NSAttributedString(string: "✓ ",
                                                                       attributes: [.foregroundColor: UIColor.white])
                    }
                }))
            }
        }
        typeButton.menu = UIMenu(options: .displayInline,
                                 children: menuChildren)
        typeButton.showsMenuAsPrimaryAction = true
        typeButton.changesSelectionAsPrimaryAction = true
        
        view.addSubview(typeButton)
        
        view.addSubview(moreButton)
        
        view.addSubview(doneButton)
        
        if documentId != "" {
            deleteButton.isHidden = false
        }
        view.addSubview(deleteButton)
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        let date = DateFormatter()
        date.dateFormat = "dd/MM/yyyy HH:mm"
        dateLabel.text = date.string(from: Date())
        stackView.addArrangedSubview(dateLabel)
        
        if note != nil {
            text.attributedText = note!
        }
        text.delegate = self
        stackView.addArrangedSubview(text)
        
        view.addSubview(vieww)
        
        vieww.addSubview(stackView2)
        
        stackView2.addArrangedSubview(textButton)
        
        stackView2.addArrangedSubview(listButton)
    }

    func setupConstraints(){
        backButton.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.width.equalTo(50)
        }
        typeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(backButton).inset(55)
            make.trailing.equalTo(moreButton).inset(55)
            make.height.equalTo(50)
        }
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.trailing.equalTo(doneButton).inset(55)
            make.height.width.equalTo(50)
        }
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.trailing.equalTo(deleteButton).inset(55)
            make.height.width.equalTo(50)
        }
        deleteButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        if documentId == "" {
            deleteButton.snp.updateConstraints { make in
                make.height.width.equalTo(0)
            }
            doneButton.snp.updateConstraints{ make in
                make.trailing.equalTo(deleteButton)
            }
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
        vieww.snp.makeConstraints { make in
            make.bottom.equalTo(view)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        stackView2.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        textButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2)
        }
        listButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
    }
    
    //MARK: Functions
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let not = textView.attributedText else { return }
        if note != nil {
            if note != not {
                doneButton.isEnabled = true
            }else if type != typeButton.titleLabel?.text {
                doneButton.isEnabled = true
            }
            else {
                doneButton.isEnabled = false
            }
        }else {
            if not != nil {
                doneButton.isEnabled = true
            } else {
                doneButton.isEnabled = false
            }
        }
    }

    func changeFont(int: Int) {
        guard let selectedTextRange = text.selectedTextRange else { return }
        
        let newFont : UIFont
        let range = text.selectedRange
        switch int {
        case 0:
            newFont = .boldSystemFont(ofSize: 23)
        case 1:
            newFont = .boldSystemFont(ofSize: 20)
        case 2:
            newFont = .boldSystemFont(ofSize: 15)
        case 3:
            newFont = .systemFont(ofSize: 15)
        default:
            return
        }
        
        let string = NSMutableAttributedString(attributedString: text.attributedText)
        string.addAttribute(.font,
                            value: newFont,
                            range: range)
        text.attributedText = string
        text.selectedRange = range
    }
    
    func changeStyle(int: Int, color: UIColor?) {
        guard let selectedTextRange = text.selectedTextRange,
                let font = text.font else { return }
        
        let string = NSMutableAttributedString(attributedString: text.attributedText)
        let range = text.selectedRange
        switch int {
        case 0:
            string.addAttribute(.font,
                                value: UIFont.boldSystemFont(ofSize: font.pointSize),
                                range: range)
        case 1:
            string.addAttribute(.font,
                                value: UIFont.italicSystemFont(ofSize: font.pointSize),
                                range: range)
        case 2:
            string.addAttribute(.underlineStyle,
                                value: NSUnderlineStyle.single.rawValue,
                                range: range)
        case 3:
            string.addAttribute(.foregroundColor,
                                value: color,
                                range: range)
        default:
            return
        }

        text.attributedText = string
        text.selectedRange = range
    }
    
    func deleteFont() {
        guard let selectedTextRange = text.selectedTextRange,
                let font = text.font else { return }
        let range = text.selectedRange
        let string = NSMutableAttributedString(attributedString: text.attributedText)
        string.addAttribute(.font,
                            value: UIFont.systemFont(ofSize: font.pointSize),
                            range: range)
        string.addAttribute(.underlineStyle,
                            value: 0,
                            range: range)
        
        text.attributedText = string
        text.selectedRange = range
    }
    
    func toDictionary() -> [[String: Any]]{
        var attributesArray : [[String : Any]] = []
        guard let attributed = text.attributedText else { return []}
        attributed.enumerateAttributes(in: NSRange(location: 0,
                                                   length: attributed.length),
                                       options: []) { attributes, range, _ in
            var dict : [String: Any] = ["range": [range.location,
                                                  range.length],
                                        "text": (attributed.string as NSString).substring(with: range)]
            for (key, value) in attributes {
                if let font = value as? UIFont {
                    dict["font"] = ["size": font.pointSize,
                                    "isBold": font.fontDescriptor.symbolicTraits.contains(.traitBold),
                                    "isItalic": font.fontDescriptor.symbolicTraits.contains(.traitItalic)]
                }
                if let color = value as? UIColor {
                    dict["color"] = color.hexString
                }
                if let underline = value as? Int {
                    dict["underline"] = underline
                }
            }
            attributesArray.append(dict)
        }
        return attributesArray
    }
    
    //MARK: Actions
    @objc func dismissVC(_ sender: UIButton){
        dismiss(animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        guard let keyboard = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        vieww.snp.updateConstraints { make in
            make.bottom.equalTo(view).inset(keyboard.height)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        vieww.snp.updateConstraints { make in
            make.bottom.equalTo(view)
        }
    }
    
    @objc func deleteAction(){
        print(userId, documentId)
        db.collection("Users").document(userId).collection("Notes").document(documentId).delete { [weak self] error in
            if error == nil {
                DispatchQueue.main.async {
                    let router = UserNotesRouter.start()
                    if let launchScreen = router.entry {
                        launchScreen.isModalInPresentation = true
                        launchScreen.modalPresentationStyle = .fullScreen
                        self?.present(launchScreen,
                                     animated: true)
                    }
                }
            }else {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert, animated: true)
            }
        }
    }
    
    @objc func saveNote(_ sender: UIButton){
        guard let note = text.text else { return }
        if note != "",
            documentId != "",
            userId != "" {
            let date = DateFormatter()
            date.dateFormat = "dd/MM/yyyy HH:mm"
            let datee = date.string(from: Date())
            let type = typeButton.titleLabel?.text
            Task {
                do {
                    try await db.collection("Users").document(userId).collection("Notes").document(documentId).setData(["note": toDictionary(),
                                                                                                                        "date": datee,
                                                                                                                        "type": type])
                    DispatchQueue.main.async {
                        let router = UserNotesRouter.start()
                        if let launchScreen = router.entry {
                            launchScreen.isModalInPresentation = true
                            launchScreen.modalPresentationStyle = .fullScreen
                            self.present(launchScreen,
                                         animated: true)
                        }
                    }
                }catch{
                    print(error)
                }
            }
        }else {
            if userId != "" {
                let date = DateFormatter()
                date.dateFormat = "dd/MM/yyyy HH:mm"
                let datee = date.string(from: Date())
                let type = typeButton.titleLabel?.text
                Task {
                    do {
                        try await db.collection("Users").document(userId).collection("Notes").document().setData(["note": toDictionary(),
                                                                                                                  "date": datee,
                                                                                                                  "type": type])
                        let router = UserNotesRouter.start()
                        if let launchScreen = router.entry {
                            launchScreen.isModalInPresentation = true
                            launchScreen.modalPresentationStyle = .fullScreen
                            self.present(launchScreen, animated: true)
                        }
                    }catch{
                        print(error)
                    }
                }
            }
        }
    }
    
    @objc func textButtonAction(_ sender: UIButton){
        vieww.isHidden = true
        let textvc = TextVC()
        textvc.modalPresentationStyle = .formSheet
        textvc.delegate = self
        textvc.sheetPresentationController?.detents = [.custom(resolver: { context in
            160
        })]
        present(textvc, animated: true)
    }
    
    @objc func listButtonAction(_ sender: UIButton){
        guard let selectedTextRange = text.selectedTextRange else { return }
        let range = text.selectedRange
        var string = NSMutableString(string: text.text(in: selectedTextRange) ?? "")
        if sender.backgroundColor == UIColor(named: "Orange"){
            if string.hasPrefix("• ") == true {
                string.deleteCharacters(in: NSRange(location: 0,
                                                    length: 2))
            }
            sender.backgroundColor = UIColor(named: "DarkGray3")
        }else {
            sender.backgroundColor = UIColor(named: "Orange")
            string.insert("• ",
                          at: 0)
        }
        let newText = NSMutableString(string: text.text)
        newText.replaceCharacters(in: range,
                                  with: string as String)
        text.text = newText as String
        text.selectedRange = range
    }
    
    @objc func openBar(_ sender: UIButton){
        vieww.isHidden = false
    }
}


