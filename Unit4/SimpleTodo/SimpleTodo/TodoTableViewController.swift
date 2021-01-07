//
//  TodoTableViewController.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/07.
//

import UIKit

class TodoTableViewController: UITableViewController {
    let cellId = "todoCell"
    
    let deleteBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deletePressed))
        return button
    }()
    
    let addBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        return button
    }()
    
    let todos = [
        Todo(title: "Buy Hamburger", todoDescription: "Buy to eat", priorityNumber: 1, isCompletedIndicator: false),
        Todo(title: "Take a walk", todoDescription: "Take a walk to park", priorityNumber: 1, isCompletedIndicator: false),
        Todo(title: "Study iOS", todoDescription: "study swift", priorityNumber: 0, isCompletedIndicator: false),
        Todo(title: "Study Design pattern", todoDescription: "design pattern", priorityNumber: 2, isCompletedIndicator: false)
    ]
    
    let sectionHeaders = ["Hight Priority", "Medium Priority", "Low Priority"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }

    func setupNavBar() {
        title = "Todo Items"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItems = [addBarButton, deleteBarButton]
    }

    @objc func deletePressed() {
    }
    
    @objc func addPressed() {
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaders.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch todos[indexPath.row].priorityNumber {
//        case 0:
//            return sectionHeaders[0]
//        case 1:
//            return sectionHeaders[1]
//        case 2:
//            return sectionHeaders[2]
//        default:
//            fatalError("it's invalid number.")
//        }
//        return todos[indexPath.row].priorityNumber
//    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
