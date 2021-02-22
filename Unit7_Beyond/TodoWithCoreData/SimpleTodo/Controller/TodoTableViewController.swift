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
        Todo(todoId: 1, title: "Study Java")
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
        cell.todoNameLabel.text = todos[indexPath.row].title
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
    
}
