//
//  DoorwayViewController.swift
//  Assignment3
//
//  Created by 杉原大貴 on 2020/12/15.
//

import UIKit

class DoorwayViewController: UIViewController {

    let imageView: UIImageView = {
      let iv = UIImageView(image: UIImage(named: "front_door"))
      iv.translatesAutoresizingMaskIntoConstraints = false
      iv.contentMode = .scaleAspectFit
      return iv
    }()
    
    let doorwaybutton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Doorway", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 50)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        view.addSubview(doorwaybutton)
        doorwaybutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doorwaybutton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        doorwaybutton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        doorwaybutton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
    }
}
