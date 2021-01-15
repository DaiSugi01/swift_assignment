//
//  ViewController.swift
//  NavBarAnimation
//
//  Created by 杉原大貴 on 2021/01/14.
//

import UIKit

class ViewController: UIViewController {

    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "DDDDDD")
        return view
    }()

    let addButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("＋", for: .normal)
        bt.setTitleColor(.blue, for: .normal)
        bt.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
        bt.addTarget(self, action: #selector(addPressed(_:)), for: .touchUpInside)
        return bt
    }()

    let imageStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .center
        sv.spacing = 5
        return sv
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var isNavbarHideen: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(topView)
        topView.addSubview(imageStackView)
        view.addSubview(addButton)
        setupUI()
    }

    func setupUI() {
        topView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true

        addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true

        imageStackView.addArrangedSubview(createImageView(imageName:"oreos"))
        imageStackView.addArrangedSubview(createImageView(imageName:"pizza_pockets"))
        imageStackView.addArrangedSubview(createImageView(imageName:"pop_tarts"))
        imageStackView.addArrangedSubview(createImageView(imageName:"popsicle"))
        imageStackView.addArrangedSubview(createImageView(imageName:"ramen"))

        imageStackView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
        imageStackView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20).isActive = true
        imageStackView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20).isActive = true
        imageStackView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.3).isActive = true
        
        imageStackView.isHidden = true

        tableView.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: imageStackView.leadingAnchor, constant: 0).isActive = true
    }

    @objc func addPressed(_ sender: UIButton) {
        scaleNavBarHeight()
        imageStackView.isHidden = isNavbarHideen
    }

    func createImageView(imageName: String) -> UIImageView {
        let iv = UIImageView(image: UIImage(named: imageName))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        return iv
    }
    
    func scaleNavBarHeight() {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, animations: {
            if self.isNavbarHideen {
                let scaleTransform = CGAffineTransform(scaleX: 1.0, y: 5.0)
                self.topView.transform = scaleTransform

//                self.topView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
                let insets = UIEdgeInsets(top: self.topView.bounds.height, left: 0, bottom: 0, right: 0)
                self.tableView.contentInset = insets
                self.tableView.scrollIndicatorInsets = insets

                let rotateTransform = CGAffineTransform(rotationAngle: .pi / 4)
                self.addButton.transform = rotateTransform
            } else {
                self.topView.transform = .identity
                self.addButton.transform = .identity

                let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                self.tableView.contentInset = insets
                self.tableView.scrollIndicatorInsets = insets
            }

            self.isNavbarHideen.toggle()
        }, completion: nil)
    }
}

