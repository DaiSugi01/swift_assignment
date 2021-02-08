//
//  MusicListCollectionViewCell.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/05.
//

import UIKit

class MusicListCollectionViewCell: UICollectionViewCell {
    
    let sv: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
    let image: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()

//    let image: UILabel = {
//        let lb = UILabel()
//        lb.translatesAutoresizingMaskIntoConstraints = false
//        lb.textAlignment = .left
//        return lb
//    }()
    
    let songNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 25)
        return lb
    }()
    
    let artistNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 15)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sv.addArrangedSubview(image)
        sv.addArrangedSubview(songNameLabel)
        sv.addArrangedSubview(artistNameLabel)
        contentView.addSubview(sv)
        sv.matchParent()
        image.heightAnchor.constraint(equalTo: sv.heightAnchor, multiplier: 0.7).isActive = true
//        image.frame.size.height = sv.frame.height * 0.5
        image.frame.size.width = sv.frame.width
//        image.centerXYin(contentView)
//        songNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        artistNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
