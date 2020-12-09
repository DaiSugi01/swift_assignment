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
    
    /* top view */
    let topStackView: UIStackView = {
        let redContainer = UIStackView()
        redContainer.translatesAutoresizingMaskIntoConstraints = false

        // set container properties
        redContainer.backgroundColor = .red
        redContainer.axis = .horizontal
        redContainer.alignment = .center
        redContainer.distribution = .fill
        redContainer.spacing = 5
        redContainer.isLayoutMarginsRelativeArrangement = true
        redContainer.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)

        return redContainer
    }()
    
    /* orange box of top stack view container */
    var orangeBox: UIView {
        let orangeBox = UIView()
        orangeBox.translatesAutoresizingMaskIntoConstraints = false

        // set propaties
        orangeBox.backgroundColor = .orange
        return orangeBox
    }
    
    /* middle view */
    let middleView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // set container properties
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 20

        return stackView
    }()

    /* blue box of middle stack view container */
    var blueBox: UIView {
        let blueBox = UIView()
        blueBox.translatesAutoresizingMaskIntoConstraints = false

        // set propaties
        blueBox.backgroundColor = .blue

        // set constraint
        blueBox.widthAnchor.constraint(equalToConstant: 70).isActive = true
        blueBox.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        return blueBox
    }

    /* bottom view */
    let buttomPurpleBox: UIView = {
        let purpleBox = UIView()
        purpleBox.translatesAutoresizingMaskIntoConstraints = false
        purpleBox.backgroundColor = .purple
        return purpleBox
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
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        widthAnchor = mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7, constant: 0)
        widthAnchor?.isActive = true
        
        heightAnchor = mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7, constant: 0)
        heightAnchor?.isActive = true
        
        createContents()
        
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
    
    func createContents() {
        /* create top view */
        let leftBox = orangeBox
        let rightBox = orangeBox
        let container = topStackView
        
        mainView.addSubview(container)

        // set child box to container
        container.addArrangedSubview(leftBox)
        container.addArrangedSubview(rightBox)
        
        // set left box constraints
        leftBox.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.6).isActive = true
        leftBox.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5).isActive = true
        leftBox.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        
        // set right box constraints
        rightBox.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.6).isActive = true
        rightBox.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.3).isActive = true
        rightBox.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true

        // set container constraints
        container.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.3).isActive = true
        container.heightAnchor.constraint(equalToConstant: 60).isActive = true
        container.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        container.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30).isActive = true

        
        /* creata bottom view */
        let purpleBox = buttomPurpleBox
        mainView.addSubview(purpleBox)

        // set constraints
        purpleBox.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6).isActive = true
        purpleBox.heightAnchor.constraint(equalToConstant: 60).isActive = true
        purpleBox.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -30).isActive = true
        purpleBox.trailingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        

        /* create middle view */
        let blueTopBox = blueBox
        let blueMiddleBox = blueBox
        let blueBottomBox = blueBox

        // add children to container
        let middleStackView = middleView
        middleView.addArrangedSubview(blueTopBox)
        middleView.addArrangedSubview(blueMiddleBox)
        middleView.addArrangedSubview(blueBottomBox)
        
        mainView.addSubview(middleStackView)

        // set container constraint
        middleStackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        middleStackView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.5).isActive = true
        middleStackView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.6).isActive = true
        middleStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 30).isActive = true

        // set children constraint
        blueTopBox.centerXAnchor.constraint(equalTo: middleView.centerXAnchor).isActive = true
        blueMiddleBox.centerXAnchor.constraint(equalTo: middleView.centerXAnchor).isActive = true
        blueBottomBox.centerXAnchor.constraint(equalTo: middleView.centerXAnchor).isActive = true

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

