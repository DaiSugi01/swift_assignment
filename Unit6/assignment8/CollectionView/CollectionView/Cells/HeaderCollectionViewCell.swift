//
//  HeaderCollectionViewCell.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/08.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
  
    static let reuseIdentifier = "HeaderCell"
    
    let wrapperSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.backgroundColor = UIColor(hex: "132937")
        return sv
    }()
    
    let categoryLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = UIColor(hex: "132937")
        lb.textColor = UIColor(hex: "DEE8EE")
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.layer.cornerRadius = 10
        lb.textAlignment = .center
        return lb
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "132937")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(wrapperSV)
        wrapperSV.addArrangedSubview(lineView)
        wrapperSV.addArrangedSubview(categoryLabel)

        wrapperSV.matchParent()

        lineView.heightAnchor.constraint(equalTo: wrapperSV.heightAnchor, multiplier: 0.1).isActive = true
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
                }, completion: { (_) in
                    self.categoryLabel.transform = .identity
                })
                self.lineView.backgroundColor = .white
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction], animations: {
                    let scaleTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    self.categoryLabel.transform = scaleTransform
                }, completion: { (_) in
                    self.categoryLabel.transform = .identity
                })
                self.lineView.backgroundColor = UIColor(hex: "132937")
            }
        }
    }
    
    func configureCell(with genre: Genre) {
        categoryLabel.text = genre.name
    }
}
