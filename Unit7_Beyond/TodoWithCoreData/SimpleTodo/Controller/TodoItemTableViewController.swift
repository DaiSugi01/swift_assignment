//
//  TodoTableViewController.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/07.
//

import UIKit
import CoreData

class TodoItemTableViewController: UITableViewController {
    
    let sections = [
        TodoItem.Priority.PType.high,
        TodoItem.Priority.PType.middle,
        TodoItem.Priority.PType.low,
    ]
    var todoItems: [[ManagedTodoItem]] = [[], [], []]
    
    private var container: NSPersistentContainer? = AppDelegate.persistentContainer
    
    lazy var deleteBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deletePressed(_:)))
        button.tintColor = .red
        return button
    }()
    
    @objc func deletePressed(_ sender: UIBarButtonItem) {
        guard let selectedRows = tableView.indexPathsForSelectedRows else { return }
        
        let newSelectedRows = selectedRows.sorted { $0 < $1 }
        for indexPath in newSelectedRows.reversed() {
            deleteTodo(indexPath: indexPath)
        }
    }
    
    private func deleteTodo(indexPath: IndexPath) {
        guard let context = container?.viewContext else { return }
        
        let deletedTodo = todoItems[indexPath.section].remove(at: indexPath.row)
        try? ManagedTodoItem.deleteTodoItem(deleteTodo: deletedTodo, with: context)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    lazy var addBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        return button
    }()
    
    @objc func addPressed() {
        navigateToAddEditTVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
    }
    
    private func setupNavBar() {
        title = "Todo Items"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItems = [addBarButton, deleteBarButton, editButtonItem]
    }
    
    private func setupTableView() {
        let todoItemArray = try? ManagedTodoItem.fetcheTodoItems(in: container!.viewContext)
        for item in todoItemArray! {
            let sectionIndex = Int(item.priority!.id - 1)
            todoItems[sectionIndex].append(item)
            tableView.insertRows(at: [IndexPath(row: todoItems.count, section: sectionIndex)], with: .automatic)
        }
        
        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: TodoItemTableViewCell.reusableCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelectionDuringEditing = true
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func navigateToAddEditTVC() {
        let addEditTVC = AddEditTodoItemTableViewController(style: .grouped)
        addEditTVC.delegate = self
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC, animated: true, completion: nil)
    }
}

extension TodoItemTableViewController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].rawValue
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoItemTableViewCell.reusableCell, for: indexPath) as! TodoItemTableViewCell
        let todoItem = todoItems[indexPath.section][indexPath.row]
        cell.update(with: todoItem)
        cell.accessoryType = .detailDisclosureButton
        cell.showsReorderControl = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTodo(indexPath: indexPath)
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
            self.deleteTodo(indexPath: indexPath)
        }
        return [delete]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing { return }
        
        navigationItem.rightBarButtonItems = [addBarButton, editButtonItem]
        updateCheckMarkStatus(with: indexPath)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func updateCheckMarkStatus(with indexPath: IndexPath) {
        guard let context = container?.viewContext else { return }
        
        let targetTodo = todoItems[indexPath.section][indexPath.row]
        let todo = try? ManagedTodoItem.fetcheTodoItem(of: targetTodo, in: context)
        todo!.isDone.toggle()
        try? context.save()
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let context = container?.viewContext else { return }
        
        let movedTodo = todoItems[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        
        let newTodo = TodoItem(id: movedTodo.id!,
                               title: movedTodo.title!,
                               isDone: movedTodo.isDone,
                               todoDescription: movedTodo.todoDescription,
                               priority: .init(id: Int16(destinationIndexPath.section + 1),
                                               priority: sections[destinationIndexPath.section].rawValue))
        
        _ = ManagedTodoItem.updateTodoItem(currentTodoItem: movedTodo,
                                           updatedTodoItem: newTodo,
                                           with: context)
        todoItems[destinationIndexPath.section].append(movedTodo)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let addEditTVC = AddEditTodoItemTableViewController(style: .grouped)
        addEditTVC.delegate = self
        addEditTVC.todoItem = todoItems[indexPath.section][indexPath.row]
        addEditTVC.indexPath = indexPath
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC, animated: true, completion: nil)
    }
}

extension TodoItemTableViewController: AddEditTodoItemTVCDelegate {
    func add(_ todo: TodoItem) {
        guard let context = container?.viewContext else { return }
        
        let newTodo = try ManagedTodoItem.createTodoItem(of: todo, with: context)
        let newSection = Int(newTodo.priority!.id - 1)
        todoItems[newSection].append(newTodo)
        tableView.insertRows(at: [IndexPath(row: todoItems[newSection].count - 1, section: newSection)], with: .automatic)
    }
    
    func edit(_ editedTodo: TodoItem, indexPath: IndexPath) {
        guard let context = container?.viewContext else { return }
        
        let targetTodo = todoItems[indexPath.section][indexPath.row]
        let currentTodoItem = try? ManagedTodoItem.fetcheTodoItem(of: targetTodo, in: context)
        let updatedTodoItem = ManagedTodoItem.updateTodoItem(currentTodoItem: currentTodoItem!,
                                                             updatedTodoItem: editedTodo,
                                                             with: context)
        
        todoItems[indexPath.section].remove(at: indexPath.row)
        
        let section = Int(updatedTodoItem.priority!.id - 1)
        let row = todoItems[section].count
        todoItems[section].insert(updatedTodoItem, at: row)
        tableView.reloadData()
    }
}
