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
    
    let gradientLayer: CAGradientLayer = {
        let gl = CAGradientLayer()
        gl.colors = [
            UIColor(red: 0.83, green: 0.28, blue: 0.37, alpha: 1.0).cgColor,
            UIColor(red: 0.4, green: 0.0, blue: 0.0, alpha: 0.4).cgColor
        ]
        gl.startPoint = CGPoint.init(x: 0.5, y: 1)
        gl.endPoint = CGPoint.init(x: 0.5, y:0)
        return gl
    }()

    let headerWrapperView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let dismissButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("✕", for: .normal)
        bt.setTitleColor(UIColor(hex: "E4D0D1"), for: .normal)
        bt.titleLabel?.font =  UIFont.systemFont(ofSize: 36)
        bt.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
        bt.backgroundColor = .none
        return bt
    }()
    
    let headerInnerSV: UIStackView = {
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
        lb.textColor = .white
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        return lb
    }()
    
    let releaseDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.textAlignment = .left
        return lb
    }()
    
    let backdropImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = true
        iv.contentMode = .scaleAspectFill
        iv.alpha = 0.4
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
        lb.lineBreakMode = .byWordWrapping
        return lb
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupContents()
    }
    
    private func setupLayout() {
        view.backgroundColor = UIColor(hex: "132937")
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(wrapperSV)

        wrapperSV.addArrangedSubview(headerWrapperView)

        headerWrapperView.addSubview(backdropImage)
        headerWrapperView.addSubview(headerInnerSV)
        headerWrapperView.addSubview(dismissButton)

        headerInnerSV.addArrangedSubview(titleLabel)
        headerInnerSV.addArrangedSubview(releaseDateLabel)
        
        scrollView.anchors(
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor,
            trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor
        )
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        wrapperSV.anchors(
            topAnchor: scrollView.contentLayoutGuide.topAnchor,
            leadingAnchor: scrollView.frameLayoutGuide.leadingAnchor,
            trailingAnchor: scrollView.frameLayoutGuide.trailingAnchor,
            bottomAnchor: scrollView.contentLayoutGuide.bottomAnchor
        )
        
        let headerWidth = view.frame.width
        let headerHeight = view.frame.height * 0.55

        // header wrapper view constraints
        headerWrapperView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor).isActive = true
        headerWrapperView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor).isActive = true
        headerWrapperView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true

        // dismiss button constraints
        dismissButton.topAnchor.constraint(equalTo: headerWrapperView.topAnchor, constant: 5).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: headerWrapperView.leadingAnchor).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 50).isActive = true

        headerInnerSV.widthAnchor.constraint(equalTo: headerWrapperView.widthAnchor, multiplier: 0.8).isActive = true
        headerInnerSV.topAnchor.constraint(equalTo: headerWrapperView.topAnchor, constant: headerHeight / 2).isActive = true
        headerInnerSV.leadingAnchor.constraint(equalTo: headerWrapperView.leadingAnchor, constant: 20).isActive = true
        headerInnerSV.trailingAnchor.constraint(equalTo: headerWrapperView.trailingAnchor, constant: -20).isActive = true


        backdropImage.frame = .init(
            x: 0,
            y: 0,
            width: headerWidth,
            height: headerHeight
        )
        
        // set gradation
        gradientLayer.frame = CGRect(x: 0, y: 0, width: headerWidth, height: headerHeight)
        headerWrapperView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func setupContents() {
        titleLabel.text = movie?.title
        releaseDateLabel.text = "Release Date: " + String(movie!.releaseDate)
        if let imageUrl = movie!.backdropPath {
            backdropImage.image = UIImage(url: imageUrl)
        } else {
            backdropImage.image = UIImage(systemName: "photo")
        }
        rateLabel.text = "Rate: \(String(describing: movie!.voteAverage)) / 10"
        overViewContent.text = movie!.overView
    }
    
    @objc func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
