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
    let label : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        return label
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
        contentView.backgroundColor = .darkGray
        contentView.addSubview(label)
    }
    
    func setupConstraints(){
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
