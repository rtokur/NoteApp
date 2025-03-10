//
//  TextVC.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 8.03.2025.
//

import UIKit
import SnapKit

//MARK: Protocol
protocol ChangeStyle {
    func changeFont(int: Int)
    func deleteFont()
    func changeStyle(int: Int, color: UIColor?)
}

class TextVC: UIViewController {
    //MARK: Properties
    var types: [String] = ["Name",
                           "Title",
                           "Subtitle",
                           "Body"]
    var images: [UIImage] = [UIImage(systemName: "bold")!,
                             UIImage(systemName: "italic")!,
                             UIImage(systemName: "underline")!]
    var buttons: [UIButton] = []
    var buttons2: [UIButton] = []
    var delegate: ChangeStyle?

    //MARK: UI Elements
    private let stackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.text = "Style"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self,
                         action: #selector(dismissVC(_:)),
                         for: .touchUpInside)
        button.setImage(UIImage(systemName: "multiply"),
                        for: .normal)
        button.tintColor = UIColor(named: "LightGray")
        button.backgroundColor = UIColor(named: "DarkGray3")
        button.layer.cornerRadius = 12.5
        return button
    }()
    
    private let stackView3: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let stackView4: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let colorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray3
        button.layer.cornerRadius = 15
        return button
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "DarkGray2")
        setupViews()
        setupConstraints()
    }

    //MARK: Setup Methods
    func setupViews(){
        view.addSubview(stackView2)
        
        stackView2.addArrangedSubview(stackView)
        
        stackView.addArrangedSubview(label)
        
        stackView.addArrangedSubview(closeButton)
        
        stackView2.addArrangedSubview(stackView3)
        
        createFonts()
        
        stackView2.addArrangedSubview(stackView4)
        
        createStyles()
        
        createMenuButton()
        
        stackView4.addArrangedSubview(colorButton)
    }

    func setupConstraints(){
        stackView2.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        stackView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(25)
        }
        label.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(25)
        }
        stackView3.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        stackView4.snp.makeConstraints { make in
            make.height.equalTo(35)
        }
        colorButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview().dividedBy(4)
        }
    }
    
    //MARK: Functions
    func createFonts(){
        types.forEach { str in
            let button = UIButton()
            button.setTitle(str,
                            for: .normal)
            switch str {
            case "Name":
                button.titleLabel?.font = .boldSystemFont(ofSize: 23)
            case "Title":
                button.titleLabel?.font = .boldSystemFont(ofSize: 20)
            case "Subtitle":
                button.titleLabel?.font = .boldSystemFont(ofSize: 15)
            case "Body":
                button.titleLabel?.font = .systemFont(ofSize: 15)
            default:
                return
            }
            
            
            button.setTitleColor(.white,
                                 for: .normal)
            button.backgroundColor = .clear
            button.addTarget(self,
                             action: #selector(changeColor(_:)),
                             for: .touchUpInside)
            button.layer.cornerRadius = 15
            buttons.append(button)
            stackView3.addArrangedSubview(button)
            button.snp.makeConstraints { make in
                make.width.equalToSuperview().dividedBy(4)
            }
        }
    }
    
    func createStyles(){
        images.forEach { image in
            let button = UIButton()
            button.setImage(image,
                            for: .normal)
            button.tintColor = .white
            button.backgroundColor = .darkGray3
            button.layer.cornerRadius = 15
            button.addTarget(self,
                             action: #selector(changeColor2(_:)),
                             for: .touchUpInside)
            buttons2.append(button)
            stackView4.addArrangedSubview(button)
            button.snp.makeConstraints { make in
                make.width.equalToSuperview().dividedBy(4)
            }
        }
    }
    
    func createMenuButton(){
        let blue = UIAction(title: "Blue",
                            image: UIImage(systemName: "circle.fill")){ _ in
            self.delegate?.changeStyle(int: 3,
                                       color: UIColor.blue)
        }
        let red = UIAction(title: "Red",
                           image: UIImage(systemName: "circle.fill")){ _ in
            self.delegate?.changeStyle(int: 3,
                                       color: UIColor.red)
        }
        let yellow = UIAction(title: "Yellow",
                              image: UIImage(systemName: "circle.fill")){ _ in
            self.delegate?.changeStyle(int: 3,
                                       color: UIColor.yellow)
        }
        let white = UIAction(title: "White",
                             image: UIImage(systemName: "circle.fill")){ _ in
            self.delegate?.changeStyle(int: 3,
                                       color: UIColor.white)
        }
        let green = UIAction(title: "Green",
                             image: UIImage(systemName: "circle.fill")){ _ in
            self.delegate?.changeStyle(int: 3,
                                       color: UIColor.green)
        }
        let brown = UIAction(title: "Brown",
                             image: UIImage(systemName: "circle.fill")){ _ in
            self.delegate?.changeStyle(int: 3,
                                       color: UIColor.brown)
        }
        let menu = UIMenu(image: UIImage(systemName: "circle.fill"),
                          options: .displayInline,
                          children: [blue,
                                     red,
                                     yellow,
                                     white,
                                     green,
                                     brown])
        colorButton.menu = menu
        colorButton.showsMenuAsPrimaryAction = true
    }
    
    //MARK: Actions
    @objc func dismissVC(_ sender: UIButton){
        dismiss(animated: true)
    }
    
    @objc func changeColor(_ sender: UIButton){
        if sender.backgroundColor != UIColor(named: "Orange") {
            sender.backgroundColor = UIColor(named: "Orange")
            let index = buttons.firstIndex(of: sender)!
            for i in buttons.indices {
                if i == index {
                    continue
                }
                buttons[i].backgroundColor = .clear
            }
            delegate?.changeFont(int: index)
        }else {
            sender.backgroundColor = .clear
            delegate?.deleteFont()
        }
    }
    
    @objc func changeColor2(_ sender: UIButton){
        if sender.backgroundColor != UIColor(named: "Orange") {
            sender.backgroundColor = UIColor(named: "Orange")
            let index = buttons2.firstIndex(of: sender)!
            for i in buttons2.indices {
                if i == index {
                    continue
                }
                buttons2[i].backgroundColor = UIColor(named: "DarkGray3")
            }
            delegate?.changeStyle(int: index,
                                  color: nil)
        }else {
            sender.backgroundColor = UIColor(named: "DarkGray3")
            delegate?.deleteFont()
        }
        
    }
}
