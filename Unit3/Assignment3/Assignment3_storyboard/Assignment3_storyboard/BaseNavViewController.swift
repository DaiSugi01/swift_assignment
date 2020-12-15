//
//  BaseNavViewController.swift
//  Assignment3_storyboard
//
//  Created by 杉原大貴 on 2020/12/15.
//

import UIKit

class BaseNavViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Back to First Door", style: .plain, target: self, action: #selector(goBackButtonTapped(_:)))
    }

    @objc func goBackButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
}
