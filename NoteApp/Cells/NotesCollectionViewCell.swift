//
//  NotesCollectionViewCell.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 3.03.2025.
//

import UIKit
import SnapKit

class NotesCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    let stackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 20
        return stackview
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = UIColor(named: "LightGray")
        label.text = "20 Oct, 2025"
        return label
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.text = "Design Smart Home"
        return label
    }()
    
    let noteLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = UIColor(named: "LightGray")
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.right"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "DarkGray3")
        button.layer.cornerRadius = 25
        return button
    }()
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup Methods
    func setupViews(){
        contentView.backgroundColor = UIColor(named: "DarkGray2")
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(noteLabel)
        
        contentView.addSubview(button)
    }
    
    func setupConstraints(){
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        noteLabel.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        button.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(50)
        }
    }
}
