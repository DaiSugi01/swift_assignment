//
//  TodoTableViewController.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/09.
//

import UIKit

class TodoTableViewController: UITableViewController {
    
    let cellId = "todoCell"

    lazy var deleteBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deletePressed))
        return button
    }()
    
    lazy var addBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        return button
    }()

    var todos: [Todo] = [
        Todo(todoId: 0, title: "Study Swift"),
        Todo(todoId: 1, title: "Shoping")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todo Lists"
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: cellId)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItems = [addBarButton, deleteBarButton]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodoTableViewCell
        cell.todoNameLabel.text = todos[0].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoItemVC = TodoItemTableViewController()
        navigationController?.pushViewController(todoItemVC, animated: true)
    }
    
    @objc func deletePressed() {
    }
    
    @objc func addPressed() {
    }

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