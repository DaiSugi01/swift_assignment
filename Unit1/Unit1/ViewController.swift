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
        updateUI()
    }

    fileprivate func updateUI() {
        view.backgroundColor = lightOn ? .white : .black
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        lightOn.toggle()
        updateUI()
    }
    
}

