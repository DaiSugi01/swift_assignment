//
//  MenuTableViewController.swift
//  OrderApp
//
//  Created by 杉原大貴 on 2021/01/22.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    let category: String
    let menuController = MenuController()
    var menuItems = [MenuItem]()

    init?(coder: NSCoder, category: String) {
        self.category = category
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        menuController.fetchMenuItems(forCategory: category)
        { (result) in
            switch result {
            case .success(let menuItems):
                self.updateUI(with: menuItems)
            case .failure(let error):
                self.displayError(error, title: "Failed to Fetch Menu Items for \(self.category)")
            }
        }
    }
    
    func updateUI(with menuItems: [MenuItem]) {
        DispatchQueue.main.async {
            self.menuItems = menuItems
            self.tableView.reloadData()
        }
    }
    
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message:
                                            error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style:
                                            .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
