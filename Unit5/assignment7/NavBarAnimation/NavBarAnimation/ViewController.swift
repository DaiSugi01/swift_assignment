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
    
    let navTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Snacks"
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 20)
        lb.textAlignment = .center
        return lb
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
    
    let cellId = "snackCellId"
    var snacks = [String]()
    var isNavbarHideen: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SnackTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        view.addSubview(topView)
        view.addSubview(navTitle)
        topView.addSubview(imageStackView)
        view.addSubview(addButton)
        
        setupUI()
    }

    func setupUI() {
        // set top view constraints
        topView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true

        // set nav title label constraints
        navTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        navTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        navTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        
        // set add button constraints
        addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true

        // add items into stack view
        imageStackView.addArrangedSubview(createImageView(imageName:"oreos"))
        imageStackView.addArrangedSubview(createImageView(imageName:"pizza_pockets"))
        imageStackView.addArrangedSubview(createImageView(imageName:"pop_tarts"))
        imageStackView.addArrangedSubview(createImageView(imageName:"popsicle"))
        imageStackView.addArrangedSubview(createImageView(imageName:"ramen"))

        // set stack view constraints
        imageStackView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
        imageStackView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20).isActive = true
        imageStackView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20).isActive = true
        imageStackView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.3).isActive = true
        imageStackView.isHidden = true

        // set table view constraints
        tableView.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    }

    @objc func addPressed(_ sender: UIButton) {
        scaleNavBarHeight()
        imageStackView.isHidden = isNavbarHideen
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        guard let name = tappedImage.restorationIdentifier else { return }
        snacks.append(name)
        tableView.insertRows(at: [IndexPath(row: snacks.count - 1, section: 0)], with: .automatic)
    }

    func createImageView(imageName: String) -> UIImageView {
        let iv = UIImageView(image: UIImage(named: imageName))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.restorationIdentifier = imageName
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tapGestureRecognizer)
        return iv
    }

    func scaleNavBarHeight() {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, animations: {
            if self.isNavbarHideen {
                let scaleTopView = CGAffineTransform(scaleX: 1.0, y: 3.3)
                self.topView.transform = scaleTopView

                let translateTitle = CGAffineTransform(translationX: self.topView.frame.width / 2 - 200, y: self.topView.bounds.size.height / 2 - 30)
                self.navTitle.text = "ADD a Snack"
                self.navTitle.transform = translateTitle
                
                let rotateAddButton = CGAffineTransform(rotationAngle: .pi / 4)
                self.addButton.transform = rotateAddButton

                self.tableView.contentInset = UIEdgeInsets(top: self.topView.bounds.height + 10, left: 0, bottom: 0, right: 0)
            } else {
                self.topView.transform = .identity
                self.navTitle.transform = .identity
                self.navTitle.text = "Snack"
                self.addButton.transform = .identity
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }

            self.isNavbarHideen.toggle()
        }, completion: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snacks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SnackTableViewCell        
        cell.textLabel?.text = snacks[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
