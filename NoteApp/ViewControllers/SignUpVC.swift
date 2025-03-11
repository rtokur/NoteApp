//
//  SignUpVC.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 6.03.2025.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore

class SignUpVC: UIViewController {

    //MARK: Properties
    let db = Firestore.firestore()
    
    //MARK: UI Elements
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 17
        return stack
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "icon2")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Sign Up To NoteApp"
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Username"
        return label
    }()
    
    private let nameText: UITextField = {
        let name = UITextField()
        name.font = .systemFont(ofSize: 17)
        name.textAlignment = .left
        name.textColor = .white
        name.attributedPlaceholder = NSAttributedString(string: "Enter your username...",
                                                         attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "LightGray")!])
        name.layer.cornerRadius = 30
        name.backgroundColor = UIColor(named: "DarkGray3")
        name.autocapitalizationType = .none
        return name
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Email Adress"
        return label
    }()
    
    private let emailText: UITextField = {
        let email = UITextField()
        email.font = .systemFont(ofSize: 17)
        email.textAlignment = .left
        email.textColor = .white
        email.attributedPlaceholder = NSAttributedString(string: "Enter your email adress...",
                                                         attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "LightGray")!])
        email.layer.cornerRadius = 30
        email.backgroundColor = UIColor(named: "DarkGray3")
        email.autocapitalizationType = .none
        return email
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Password"
        return label
    }()
    
    private let passwordText: UITextField = {
        let password = UITextField()
        password.font = .systemFont(ofSize: 17)
        password.textAlignment = .left
        password.textColor = .white
        password.layer.cornerRadius = 30
        password.backgroundColor = UIColor(named: "DarkGray3")
        password.attributedPlaceholder = NSAttributedString(string: "Enter your password...",
                                                            attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "LightGray")!])
        password.isSecureTextEntry = true
        password.autocapitalizationType = .none
        return password
    }()
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Confirm Password"
        return label
    }()
    
    private let confirmPasswordText: UITextField = {
        let password = UITextField()
        password.font = .systemFont(ofSize: 17)
        password.textAlignment = .left
        password.textColor = .white
        password.layer.cornerRadius = 30
        password.backgroundColor = UIColor(named: "DarkGray3")
        password.attributedPlaceholder = NSAttributedString(string: "Enter your password...",
                                                            attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "LightGray")!])
        password.isSecureTextEntry = true
        password.autocapitalizationType = .none
        return password
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Orange")
        button.setTitle("Create Account",
                        for: .normal)
        button.setTitleColor(.white,
                             for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 30
        button.addTarget(self,
                         action: #selector(signUpButtonAction(_:)),
                         for: .touchUpInside)
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(named: "Orange"),
                             for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setAttributedTitle(NSAttributedString(string: "I Already Have Account",
                                                     attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]),
                                  for: .normal)
        button.addTarget(self,
                         action: #selector(dismissVC(_:)),
                         for: .touchUpInside)
        return button
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

        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(image)
        
        stackView.addArrangedSubview(label)
        
        stackView.addArrangedSubview(nameLabel)
        
        let padding4 = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: 20,
                                            height: nameText.frame.height))
        nameText.leftView = padding4
        nameText.leftViewMode = .always
        stackView.addArrangedSubview(nameText)
        
        stackView.addArrangedSubview(emailLabel)
        
        let padding = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: 20,
                                           height: emailText.frame.height))
        emailText.leftView = padding
        emailText.leftViewMode = .always
        stackView.addArrangedSubview(emailText)
        
        stackView.addArrangedSubview(passwordLabel)
        
        let padding2 = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: 20,
                                            height: passwordText.frame.height))
        passwordText.leftView = padding2
        passwordText.leftViewMode = .always
        stackView.addArrangedSubview(passwordText)
        
        stackView.addArrangedSubview(confirmPasswordLabel)
        
        let padding3 = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: 20,
                                            height: confirmPasswordText.frame.height))
        confirmPasswordText.leftView = padding3
        confirmPasswordText.leftViewMode = .always
        stackView.addArrangedSubview(confirmPasswordText)
        
        stackView.addArrangedSubview(signUpButton)
        
        stackView.addArrangedSubview(signInButton)
    }

    func setupConstraints(){
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
        stackView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(scrollView.contentLayoutGuide)
        }
        image.snp.makeConstraints { make in
            make.height.width.equalTo(70)
        }
        label.snp.makeConstraints { make in
            make.height.equalTo(27)
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        nameText.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        emailLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        emailText.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        passwordLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        passwordText.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        confirmPasswordLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        confirmPasswordText.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
    
    //MARK: Actions
    @objc func dismissVC(_ sender: UIButton){
        dismiss(animated: true)
    }
    
    @objc func signUpButtonAction(_ sender: UIButton){
        guard let email = emailText.text ,
                let password = passwordText.text,
                let password2 = confirmPasswordText.text,
                password == password2,
                let username = nameText.text else {
            let alert = UIAlertController(title: "Error",
                                          message: "Please fill all area.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .cancel))
            self.present(alert,
                         animated: true)
            return
        }
        
        Task{
            try await Auth.auth().createUser(withEmail: email,
                                             password: password) { result, error in
                guard error == nil else {
                    let alert = UIAlertController(title: "Error",
                                                  message: error?.localizedDescription,
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK",
                                                  style: .cancel))
                    self.present(alert,
                                 animated: true)
                    return
                }
                
                do {
                    if let userId = result?.user.uid as? String {
                        self.db.collection("Users").document(userId).setData(["userName": username,
                                                                              "email": email]) { error in
                            guard error == nil else {
                                let alert = UIAlertController(title: "Error",
                                                              message: error?.localizedDescription,
                                                              preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK",
                                                              style: .cancel))
                                self.present(alert,
                                             animated: true)
                                return
                            }
                            
                            let router = UserNotesRouter.start()
                            if let launchScreen = router.entry {
                                launchScreen.isModalInPresentation = true
                                launchScreen.modalPresentationStyle = .fullScreen
                                self.present(launchScreen,
                                             animated: true)
                            }
                        }
                    }
                }catch{
                    let alert = UIAlertController(title: "Error",
                                                  message: error.localizedDescription,
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK",
                                                  style: .cancel))
                    self.present(alert,
                                 animated: true)
                }
                
            }
        }
    }
    
}
