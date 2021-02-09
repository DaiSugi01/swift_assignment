//
//  HeaderCollectionViewCell.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/05.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
  
    static let reuseIdentifier = "HeaderCell"
    
    let categoryLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = .white
        lb.textColor = .systemTeal
        lb.clipsToBounds = true
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        lb.layer.cornerRadius = 10
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryLabel)
        categoryLabel.matchParent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction], animations: {
                    let scaleTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    self.categoryLabel.transform = scaleTransform
                    self.categoryLabel.textColor = .white
                    self.categoryLabel.backgroundColor = .systemTeal
                }, completion: { (_) in
                    self.categoryLabel.transform = .identity
                })
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction], animations: {
                    let scaleTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    self.categoryLabel.transform = scaleTransform
                    self.categoryLabel.textColor = .systemTeal
                    self.categoryLabel.backgroundColor = .white
                }, completion: { (_) in
                    self.categoryLabel.transform = .identity
                })
            }
        }
    }
    
    func configureCell(with genre: Genre) {
        categoryLabel.text = genre.name
    }
}
