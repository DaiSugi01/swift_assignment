//
//  MovieListCollectionViewCell.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/08.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "movieReuseIdentifier"
    
    let wrapperSV: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = .white
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.clipsToBounds = true
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 0
        sv.layer.cornerRadius = 10
        return sv
    }()
    
    let posterImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .black
        return iv
    }()

    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 2
        lb.backgroundColor = UIColor(hex: "F9F8EB")
        lb.text = "no title"
        lb.textAlignment = .center
        lb.lineBreakMode = .byWordWrapping
        lb.font = UIFont.systemFont(ofSize: 15)
        return lb
    }()
    
    let buttomWrapperSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.backgroundColor = UIColor(hex: "FEF298")
        sv.alignment = .fill
        return sv
    }()
    
    let buttomLeftSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()

    let voteButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        bt.tintColor = .black
        bt.titleLabel?.textAlignment = .center
        return bt
    }()
    
    let voteLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "11"
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 15)
        return lb
    }()
    
    let buttomRightSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.backgroundColor = .white
        return sv
    }()

    let rateButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(systemName: "star"), for: .normal)
        bt.tintColor = UIColor(hex: "F9B800")
        bt.titleLabel?.textAlignment = .center
        return bt
    }()
    
    let rateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "11"
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 15)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        wrapperSV.addArrangedSubview(posterImage)
        wrapperSV.addArrangedSubview(titleLabel)
        wrapperSV.addArrangedSubview(buttomWrapperSV)

        buttomWrapperSV.addArrangedSubview(buttomLeftSV)
        buttomWrapperSV.addArrangedSubview(buttomRightSV)
        
        buttomLeftSV.addArrangedSubview(voteButton)
        buttomLeftSV.addArrangedSubview(voteLabel)

        buttomRightSV.addArrangedSubview(rateButton)
        buttomRightSV.addArrangedSubview(rateLabel)

        contentView.addSubview(wrapperSV)
        wrapperSV.matchParent()
        posterImage.heightAnchor.constraint(equalTo: wrapperSV.heightAnchor, multiplier: 0.7).isActive = true
        posterImage.frame.size.width = wrapperSV.frame.width
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with movie: Movie) {
        if let imagePath = movie.imagePath {
            posterImage.image = (imagePath.isEmpty) ? UIImage(named: "noimage") : UIImage(url: imagePath)
        } else {
            posterImage.image = UIImage(named: "noimage")
        }
        titleLabel.text = movie.title
        voteLabel.text = String(describing: movie.voteCount)
        rateLabel.text = String(describing: movie.voteAverage)
    }
}
