//
//  MovieListCollectionViewCell.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/08.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    static let gridReuseIdentifier = "movieGridReuseIdentifier"
    static let columnReuseIdentifier = "movieColumnReuseIdentifier"

    let wrapperSV: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = .white
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.clipsToBounds = true
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 0
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
        lb.backgroundColor = UIColor(hex: "1D4159")
        lb.textColor = UIColor(hex: "DEE8EE")
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
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
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
    }
    
    private func setupConstraints() {
        // wrapper stack view
        wrapperSV.matchParent()
        
        // poster image
        posterImage.heightAnchor.constraint(equalTo: wrapperSV.heightAnchor, multiplier: 0.7).isActive = true
        posterImage.frame.size.width = wrapperSV.frame.width
        
        buttomWrapperSV.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureCell(with movie: Movie) {
        if let imagePath = movie.posterImagePath {
            posterImage.image = (imagePath.isEmpty) ? UIImage(named: "noimage") : UIImage(url: imagePath)
        } else {
            posterImage.image = UIImage(named: "noimage")
        }
        titleLabel.text = movie.title
        voteLabel.text = String(describing: movie.voteCount)
        rateLabel.text = String(describing: movie.voteAverage)
    }
}
