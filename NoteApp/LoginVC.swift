//
//  CalendarVC.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 4.03.2025.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    //MARK: UI Elements
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"),
                        for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "DarkGray3")
        button.addTarget(self,
                         action: #selector(dismissVC(_:)),
                         for: .touchUpInside)
        button.layer.cornerRadius = 25
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
        label.text = "Sign In To NoteApp"
        return label
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
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Orange")
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 30
        button.addTarget(self,
                         action: #selector(signInButtonAction(_:)),
                         for: .touchUpInside)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Create New Account",
                        for: .normal)
        button.setTitleColor(UIColor(named: "Orange"),
                             for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 30
        button.layer.borderColor = UIColor(named: "Orange")!.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self,
                         action: #selector(signUpButtonAction(_:)),
                         for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(named: "Orange"),
                             for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setAttributedTitle(NSAttributedString(string: "Forgot Password",
                                                     attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]),
                                  for: .normal)
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
        
        view.addSubview(backButton)
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(image)
        
        stackView.addArrangedSubview(label)
        
        stackView.addArrangedSubview(emailLabel)
        
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: emailText.frame.height))
        emailText.leftView = padding
        emailText.leftViewMode = .always
        stackView.addArrangedSubview(emailText)
        
        stackView.addArrangedSubview(passwordLabel)
        
        let padding2 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: passwordText.frame.height))
        passwordText.leftView = padding2
        passwordText.leftViewMode = .always
        stackView.addArrangedSubview(passwordText)
        
        stackView.addArrangedSubview(signInButton)
        
        stackView.addArrangedSubview(signUpButton)
        
        stackView.addArrangedSubview(forgotPasswordButton)
    }

    func setupConstraints(){
        backButton.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.width.equalTo(50)
        }
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
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        forgotPasswordButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
    
    //MARK: Actions
    @objc func dismissVC(_ sender: UIButton){
        dismiss(animated: true)
    }
    
    @objc func signInButtonAction(_ sender: UIButton){
        guard let email = emailText.text ,
                let password = passwordText.text else { return }
        Task{
            Auth.auth().signIn(withEmail: email ,
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
                
                let router = UserNotesRouter.start()
                if let launchScreen = router.entry {
                    launchScreen.isModalInPresentation = true
                    launchScreen.modalPresentationStyle = .fullScreen
                    self.present(launchScreen,
                                 animated: true)
                }
            }
        }
    }
    
    @objc func signUpButtonAction(_ sender: UIButton){
        let signUp = SignUpVC()
        signUp.modalPresentationStyle = .fullScreen
        signUp.isModalInPresentation = true
        present(signUp,
                animated: true)
    }
}

