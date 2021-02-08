//
//  HeaderCollectionViewCell.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/05.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
  
    let genreLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = .white
        lb.textColor = .systemTeal
        lb.layer.cornerRadius = 10
        lb.textAlignment = .center
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(genreLabel)
        genreLabel.matchParent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                genreLabel.textColor = .white
                genreLabel.backgroundColor = .systemTeal
            } else {
                genreLabel.textColor = .systemTeal
                genreLabel.backgroundColor = .white
            }
        }
    }
}
