//
//  DetailViewController.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/08.
//

import UIKit

class DetailViewController: UIViewController {
    var movie: Movie?
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let wrapperSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 0
        return sv
    }()
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        return lb
    }()
    
    let releaseDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        return lb
    }()
    
    let posterImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = true
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .black
        return iv
    }()
    
    let rateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        return lb
    }()
    
    let overView: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.text = "Overview"
        return lb
    }()
    
    let overViewContent: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.numberOfLines = 0
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupContents()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(wrapperSV)
        
        wrapperSV.addArrangedSubview(titleLabel)
        wrapperSV.addArrangedSubview(releaseDateLabel)
        wrapperSV.addArrangedSubview(posterImage)
        wrapperSV.addArrangedSubview(rateLabel)
        wrapperSV.addArrangedSubview(overView)
        wrapperSV.addArrangedSubview(overViewContent)
        
        scrollView.matchParent()
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        wrapperSV.anchors(
            topAnchor: scrollView.contentLayoutGuide.topAnchor,
            leadingAnchor: scrollView.frameLayoutGuide.leadingAnchor,
            trailingAnchor: scrollView.frameLayoutGuide.trailingAnchor,
            bottomAnchor: scrollView.contentLayoutGuide.bottomAnchor
        )

        posterImage.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setupContents() {
        titleLabel.text = movie?.title
        releaseDateLabel.text = "Release Date: " + String(movie!.releaseDate)
        posterImage.image = UIImage(url: movie!.imagePath!)
        rateLabel.text = "Rate: \(String(describing: movie!.voteAverage)) / 10"
        overViewContent.text = movie!.overView
    }
    
}
