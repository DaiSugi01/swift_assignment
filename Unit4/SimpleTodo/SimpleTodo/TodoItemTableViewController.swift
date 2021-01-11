//
//  TodoTableViewController.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/07.
//

import UIKit

class TodoItemTableViewController: UITableViewController, AddEditTodoItemTVCDelegate {
    
    let cellId = "todoItemCell"
    
    lazy var deleteBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deletePressed))
        return button
    }()
    
    lazy var addBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        return button
    }()
    
    var todoItems: [[TodoItem]] = [
        [
            TodoItem(title: "Study iOS", checkMark: "", todoDescription: "study swift", priorityNumber: 0),
            TodoItem(title: "Study Design pattern", checkMark: "", todoDescription: "design pattern", priorityNumber: 0)
        ],
        [
            TodoItem(title: "Buy Hamburger", checkMark: "", todoDescription: "Buy to eat", priorityNumber: 1),
            TodoItem(title: "Take a walk", checkMark: "", todoDescription: "Take a walk to park", priorityNumber: 1),
        ],
        [
            TodoItem(title: "Cook lanch", checkMark: "", todoDescription: "Cook lanch", priorityNumber: 2),
            TodoItem(title: "Cook diner", checkMark: "", todoDescription: "Cook dinner", priorityNumber: 2 )
        ]
    ]
    
    let sectionHeaders = ["Hight Priority", "Medium Priority", "Low Priority"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelectionDuringEditing = true
    }

    func setupNavBar() {
        title = "Todo Items"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItems = [addBarButton, deleteBarButton, editButtonItem]
    }
    
    private func navigateToAddEditTVC() {
        let addEditTVC = AddEditTodoItemTableViewController(style: .grouped)
        addEditTVC.delegate = self
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC, animated: true, completion: nil)
    }
    
    func add(_ todo: TodoItem) {
        todoItems[1].append(todo)
        tableView.insertRows(at: [IndexPath(row: todoItems[1].count - 1, section: 1)], with: .automatic)
    }
    
    func edit(_ todo: TodoItem) {
        if let indexPath = tableView.indexPathForSelectedRow {
            todoItems.remove(at: indexPath.row)
            todoItems[indexPath.section].insert(todo, at: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @objc func deletePressed() {
    }
    
    @objc func addPressed() {
        print("run")
        navigateToAddEditTVC()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaders.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodoItemTableViewCell
        cell.todoName.text = todoItems[indexPath.section][indexPath.row].title
        cell.checkMark.text = todoItems[indexPath.section][indexPath.row].checkMark
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        todoItems[indexPath.section].remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
//            // delete item at indexPath
//        }
//
//        return [delete]
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateCheckMark(with: indexPath)
//        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func updateCheckMark(with indexPath: IndexPath) {
        if todoItems[indexPath.section][indexPath.row].checkMark == "" {
            todoItems[indexPath.section][indexPath.row].checkMark = "✓"
        } else {
            todoItems[indexPath.section][indexPath.row].checkMark = ""
        }
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
