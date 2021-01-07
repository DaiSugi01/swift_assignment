//
//  TempViewController.swift
//  TipCalculator
//
//  Created by 杉原大貴 on 2021/01/06.
//

import UIKit

class TempViewController: UIViewController {
    
    let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$ 00.00"
        label.textColor = .black
        return label
    }()
    
    let amountLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total Amount"
        label.textColor = .black
        return label
    }()

    let billTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Bill Amount"
        return tf
    }()
    
    let tipPercentageLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tip Percentage"
        label.textColor = .black
        return label
    }()
    
    let calculateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Calculate Tip", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        setupLayout()
    }

    func setupLayout() {
        // Scroll view
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(billTF)
        stackView.addArrangedSubview(tipPercentageLabel)
        stackView.addArrangedSubview(calculateButton)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10

//        stackView.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor).isActive = true
//        stackView.centerYAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerYAnchor).isActive = true
//        stackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        stackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0).isActive = true
        
        stackView.backgroundColor = .blue
    }

}
