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
        let button = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deletePressed(_:)))
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
            TodoItem(title: "Cook lanch", checkMark: "", todoDescription: "Cook lunch", priorityNumber: 2),
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

    private func setupNavBar() {
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
            todoItems[indexPath.section].remove(at: indexPath.row)
            todoItems[indexPath.section].insert(todo, at: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func updateCheckMark(with indexPath: IndexPath) {
        if todoItems[indexPath.section][indexPath.row].checkMark == "" {
            todoItems[indexPath.section][indexPath.row].checkMark = "✓"
        } else {
            todoItems[indexPath.section][indexPath.row].checkMark = ""
        }
    }
    
    @objc func deletePressed(_ sender: UIBarButtonItem) {
        guard let selectedRows = tableView.indexPathsForSelectedRows else { return }
        
        for indexPath in selectedRows.reversed() {
            todoItems[indexPath.section].remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
    @objc func addPressed() {
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
        cell.update(with: todoItems[indexPath.section][indexPath.row])
        cell.todoName.text = todoItems[indexPath.section][indexPath.row].title
        cell.checkMark.text = todoItems[indexPath.section][indexPath.row].checkMark
        cell.accessoryType = .detailDisclosureButton
        cell.showsReorderControl = true

        return cell
    }
    
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

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.todoItems[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [delete]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !tableView.isEditing {
            tableView.deselectRow(at: indexPath, animated: false)
            updateCheckMark(with: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let removedTodo = todoItems[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        todoItems[destinationIndexPath.section].insert(removedTodo, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let addEditTVC = AddEditTodoItemTableViewController(style: .grouped)
        addEditTVC.delegate = self
        addEditTVC.todoItem = todoItems[indexPath.section][indexPath.row]
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC, animated: true, completion: nil)
    }
}
