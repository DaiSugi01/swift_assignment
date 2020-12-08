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
        redContainer.backgroundColor = .red
        return redContainer
    }()
    
    /* child left box of top stack view container */
    let topOrangeLeftBox: UIView = {
        let orangeBox = UIView()
        orangeBox.translatesAutoresizingMaskIntoConstraints = false
        orangeBox.backgroundColor = .orange
        return orangeBox
    }()
    
    /* child right box of top stack view container */
    let topOrangeRightBox: UIView = {
        let orangeBox = UIView()
        orangeBox.translatesAutoresizingMaskIntoConstraints = false
        orangeBox.backgroundColor = .orange
        return orangeBox
    }()
    
    /* middle view */
    let middleView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    /* child top box of middle stack view container */
    let blueTopBox: UIView = {
        let blueRec = UIView()
        blueRec.translatesAutoresizingMaskIntoConstraints = false
        blueRec.backgroundColor = .blue
        return blueRec
    }()
    
    /* child middle box of middle stack view container */
    let blueMiddleBox: UIView = {
        let blueRec = UIView()
        blueRec.translatesAutoresizingMaskIntoConstraints = false
        blueRec.backgroundColor = .blue
        return blueRec
    }()
    
    /* child bottom box of middle stack view container */
    let blueBottomBox: UIView = {
        let blueRec = UIView()
        blueRec.translatesAutoresizingMaskIntoConstraints = false
        blueRec.backgroundColor = .blue
        return blueRec
    }()
    
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
        let leftBox = topOrangeLeftBox
        let rightBox = topOrangeRightBox
        let container = topStackView
        
        // set container properties
        container.axis = .horizontal
        container.alignment = .center
        container.distribution = .fill
        container.spacing = 5
        container.isLayoutMarginsRelativeArrangement = true
        container.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        mainView.addSubview(container)
        
        // set container constraints
        container.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.3).isActive = true
        container.heightAnchor.constraint(equalToConstant: 60).isActive = true
        container.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        container.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30).isActive = true

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


        /* creata bottom view */
        let purpleBox = buttomPurpleBox
        mainView.addSubview(purpleBox)

        purpleBox.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6).isActive = true
        purpleBox.heightAnchor.constraint(equalToConstant: 60).isActive = true
        purpleBox.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -30).isActive = true
        purpleBox.trailingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        

        /* create middle view */
        let blueTopRec = blueTopBox
        let blueMiddleRec = blueMiddleBox
        let blueBottomRec = blueBottomBox

        // add children to container
        let middleStackView = middleView
        middleView.addArrangedSubview(blueTopBox)
        middleView.addArrangedSubview(blueMiddleRec)
        middleView.addArrangedSubview(blueBottomRec)
        
        // set container properties
        middleStackView.axis = .vertical
        middleStackView.alignment = .center
        middleStackView.distribution = .equalSpacing
        middleView.spacing = 20
        mainView.addSubview(middleStackView)

        // set container constraint
        middleStackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        middleStackView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.5).isActive = true
        middleStackView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.6).isActive = true
        middleStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 30).isActive = true

        // set children constraint
        let blueBoxes: [UIView] = [blueTopRec, blueMiddleRec, blueBottomRec]
        for blueBox in blueBoxes {
            blueBox.widthAnchor.constraint(equalToConstant: 70).isActive = true
            blueBox.heightAnchor.constraint(equalToConstant: 70).isActive = true
            blueBox.centerXAnchor.constraint(equalTo: middleView.centerXAnchor).isActive = true
        }

    }
    
    func createTopRedBoxes() {
        let leftBox = UIView()
        leftBox.translatesAutoresizingMaskIntoConstraints = false
        leftBox.backgroundColor = .orange

        let rightBox = UIView()
        rightBox.translatesAutoresizingMaskIntoConstraints = false
        rightBox.backgroundColor = .orange

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
        
        leftBox.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6).isActive = true
        leftBox.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5).isActive = true
        leftBox.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10).isActive = true
        
        rightBox.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6).isActive = true
        rightBox.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3).isActive = true
        rightBox.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10).isActive = true

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

