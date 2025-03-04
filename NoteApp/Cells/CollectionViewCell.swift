//
//  CollectionViewCell.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 3.03.2025.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    let button : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "DarkGray")
        button.setTitleColor(UIColor(named: "LightGray"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Font", size: 25)
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
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
        contentView.addSubview(button)
    }
    
    func setupConstraints(){
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
