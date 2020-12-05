//
//  ViewController.swift
//  Unit1
//
//  Created by 杉原大貴 on 2020/12/05.
//

import UIKit

class ViewController: UIViewController {

    var lightOn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    fileprivate func updateUI() {
        if lightOn {
            view.backgroundColor = .white
        } else {
            view.backgroundColor = .black
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        lightOn.toggle()
        updateUI()
    }
    
}

