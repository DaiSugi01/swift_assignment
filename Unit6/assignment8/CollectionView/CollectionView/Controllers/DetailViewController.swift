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
        sv.spacing = 50
        return sv
    }()
    
    let gradientLayer: CAGradientLayer = {
        let gl = CAGradientLayer()
        gl.colors = [
            UIColor(red: 0.83, green: 0.28, blue: 0.37, alpha: 1.0).cgColor,
            UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
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
        lb.textColor = UIColor(hex: "FEE8EC")
        lb.font = UIFont.boldSystemFont(ofSize: 30)
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
        iv.contentMode = .scaleAspectFit
        iv.alpha = 0.2
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
    
    let headerOverviewSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 10
        return sv
    }()
    
    let overView: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 25)
        lb.textColor = UIColor(hex: "F6CED3")
        lb.text = "Overview"
        return lb
    }()
    
    let overViewContent: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.textColor = UIColor(hex: "BD97A4")
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
        view.backgroundColor = UIColor(hex: "DA5A70")
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(wrapperSV)
        scrollView.addSubview(headerWrapperView)
        
        wrapperSV.addArrangedSubview(headerWrapperView)
        wrapperSV.addArrangedSubview(headerInnerSV)
        wrapperSV.addArrangedSubview(headerOverviewSV)

        headerWrapperView.addSubview(backdropImage)
        headerWrapperView.addSubview(dismissButton)
        
        headerInnerSV.addArrangedSubview(titleLabel)
        headerInnerSV.addArrangedSubview(releaseDateLabel)
        
        headerOverviewSV.addArrangedSubview(overView)
        headerOverviewSV.addArrangedSubview(overViewContent)
        
        let imageViewWidth = view.frame.width
        let imageViewHeight = view.frame.height
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            wrapperSV.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            wrapperSV.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            wrapperSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            wrapperSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            wrapperSV.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            headerWrapperView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            headerWrapperView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            headerWrapperView.heightAnchor.constraint(equalToConstant: imageViewHeight),
            
            dismissButton.topAnchor.constraint(equalTo: headerWrapperView.topAnchor, constant: 5),
            dismissButton.leadingAnchor.constraint(equalTo: headerWrapperView.leadingAnchor),
            dismissButton.heightAnchor.constraint(equalToConstant: 50),
            dismissButton.widthAnchor.constraint(equalToConstant: 50),
            
            headerInnerSV.topAnchor.constraint(equalTo: headerWrapperView.topAnchor, constant: imageViewHeight / 6),
            headerInnerSV.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            headerInnerSV.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
            
            headerOverviewSV.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            headerOverviewSV.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        backdropImage.frame = .init(
            x: 0,
            y: 0,
            width: imageViewWidth,
            height: imageViewHeight
        )
        
        // set gradation
        gradientLayer.frame = CGRect(x: 0, y: 0, width: imageViewWidth, height: imageViewHeight)
        headerWrapperView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func setupContents() {
        titleLabel.text = movie?.title
        releaseDateLabel.text = String(movie!.releaseDate.prefix(4))
        if let imageUrl = movie!.posterImagePath {
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
