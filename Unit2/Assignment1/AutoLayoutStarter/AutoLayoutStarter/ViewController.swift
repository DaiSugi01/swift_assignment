//
//  ViewController.swift
//  AutoLayoutStarter
//
//  Created by Derrick Park on 2019-04-17.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let mainView: UIView = {
        let main = UIView()
        // important when setting contraints programmatically
        main.translatesAutoresizingMaskIntoConstraints = false
        main.backgroundColor = .green
        return main
    }()
    
    let squareButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.setTitle("Square", for: .normal)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        butt.addTarget(self, action: #selector(squareTapped), for: .touchUpInside)
        return butt
    }()
    
    let portraitButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.setTitle("Portrait", for: .normal)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        butt.addTarget(self, action: #selector(portraitTapped), for: .touchUpInside)
        return butt
    }()
    
    let landScapeButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.setTitle("Landscape", for: .normal)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        butt.addTarget(self, action: #selector(landscapeTapped), for: .touchUpInside)
        return butt
    }()
        
    var widthAnchor: NSLayoutConstraint?
    var heightAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainView)
        createPurpleBox()
        createTopRedBoxes()
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        widthAnchor = mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7, constant: 0)
        widthAnchor?.isActive = true
        
        heightAnchor = mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7, constant: 0)
        heightAnchor?.isActive = true
        
        let buttStackView = UIStackView(arrangedSubviews: [
                                            squareButton, portraitButton, landScapeButton])
        buttStackView.translatesAutoresizingMaskIntoConstraints = false
        buttStackView.axis = .horizontal
        buttStackView.alignment = .center
        buttStackView.distribution = .fillEqually
        
        view.addSubview(buttStackView)
        NSLayoutConstraint.activate([
            buttStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttStackView.heightAnchor.constraint(equalToConstant: 50),
            buttStackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func createTopRedBoxes() {
        let leftBox = UIView()
        leftBox.translatesAutoresizingMaskIntoConstraints = false
        
        let rightBox = UIView()
        rightBox.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [leftBox, rightBox])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .red
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        mainView.addSubview(stackView)
        
        stackView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.3).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        stackView.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30).isActive = true
        
        leftBox.backgroundColor = .orange
        leftBox.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6).isActive = true
        leftBox.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5).isActive = true
        leftBox.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10).isActive = true
        
        rightBox.backgroundColor = .orange
        rightBox.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6).isActive = true
        rightBox.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3).isActive = true
        rightBox.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10).isActive = true

    }
    
    func createPurpleBox() {
        let purpleRec = UIView()
        mainView.addSubview(purpleRec)

        purpleRec.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6).isActive = true
        purpleRec.heightAnchor.constraint(equalToConstant: 60).isActive = true
        purpleRec.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -30).isActive = true
        purpleRec.trailingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        purpleRec.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        purpleRec.translatesAutoresizingMaskIntoConstraints = false
        purpleRec.backgroundColor = .purple
    }
    
    @objc private func squareTapped() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 2.0) {
            self.widthAnchor?.isActive = false
            self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
            self.widthAnchor?.isActive = true
            
            self.heightAnchor?.isActive = false
            self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
            self.heightAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func portraitTapped() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 2.0) {
            self.widthAnchor?.isActive = false
            self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7)
            self.widthAnchor?.isActive = true
            
            self.heightAnchor?.isActive = false
            self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7)
            self.heightAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc private func landscapeTapped() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 2.0) {
            self.widthAnchor?.isActive = false
            self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95)
            self.widthAnchor?.isActive = true
            
            self.heightAnchor?.isActive = false
            self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
            self.heightAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }
    }
}

