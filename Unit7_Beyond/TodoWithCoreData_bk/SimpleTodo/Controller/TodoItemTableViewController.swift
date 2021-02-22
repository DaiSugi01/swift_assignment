//
//  TodoTableViewController.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/07.
//

import UIKit
import CoreData

class TodoItemTableViewController: FetchedResultsTableViewController {
        
    private let SECTION_HIGH = 0
    private let SECTION_MIDDLE = 0
    private let SECTION_LOW = 0

    let sections = [
        TodoItem.Priority.PType.high,
        TodoItem.Priority.PType.middle,
        TodoItem.Priority.PType.low,
    ]
    
    private var container: NSPersistentContainer? = AppDelegate.persistentContainer

    lazy var fetchedResultsController: NSFetchedResultsController<ManagedTodoItem> = {
        let request: NSFetchRequest<ManagedTodoItem> = ManagedTodoItem.fetchRequest()
        let priorityIdSortDescriptors = NSSortDescriptor(key: "priority.id", ascending: true)
        let titleSortDescriptors = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [priorityIdSortDescriptors, titleSortDescriptors]
        let frc = NSFetchedResultsController<ManagedTodoItem>(
            fetchRequest: request,
            managedObjectContext: container!.viewContext,
            sectionNameKeyPath: "priority.priority",
            cacheName: nil
        )
        frc.delegate = self
        return frc
    }()
    
    lazy var deleteBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deletePressed(_:)))
        return button
    }()
    
    @objc func deletePressed(_ sender: UIBarButtonItem) {
        guard let context = container?.viewContext else { return }
        guard let selectedRows = tableView.indexPathsForSelectedRows else { return }
        
        let newSelectedRows = selectedRows.sorted { $0 < $1 }
        for indexPath in newSelectedRows.reversed() {
            let deletedTodo = fetchedResultsController.object(at: indexPath)
            container?.viewContext.delete(deletedTodo)
        }
        try? context.save()
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
        
//        let a = ManagedPriority.getAllPriority(in: container!.viewContext)

//        for item in a! {
//            if let contetxt = container?.viewContext {
//                contetxt.delete(item)
//                try? contetxt.save()
//            }
//        }
    }

    private func setupNavBar() {
        title = "Todo Items"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItems = [addBarButton, deleteBarButton, editButtonItem]
    }
    
    private func setupTableView() {
        try? fetchedResultsController.performFetch()

        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: TodoItemTableViewCell.reusableCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    private func navigateToAddEditTVC() {
        let addEditTVC = AddEditTodoItemTableViewController(style: .grouped)
        addEditTVC.context = container?.viewContext
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC, animated: true, completion: nil)
    }
}

extension TodoItemTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController.sections, sections.count > 0 {
            return sections[section].name
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoItemTableViewCell.reusableCell, for: indexPath) as! TodoItemTableViewCell
        let todoItem = fetchedResultsController.object(at: indexPath)
        cell.update(with: todoItem)
        try? container?.viewContext.save()
        
        print("title: \(todoItem.title!), priority: \(todoItem.priority!.priority)")
        cell.accessoryType = .detailDisclosureButton
        cell.showsReorderControl = true

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteTodo = fetchedResultsController.object(at: indexPath)
            container?.viewContext.delete(deleteTodo)
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
            let deleteTodo = self.fetchedResultsController.object(at: indexPath)
            self.container?.viewContext.delete(deleteTodo)
        }
        return [delete]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            tableView.deselectRow(at: indexPath, animated: false)
            updateCheckMarkStatus(with: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
    private func updateCheckMarkStatus(with indexPath: IndexPath) {
        guard let context = container?.viewContext else { return }
        
        let todo = fetchedResultsController.object(at: indexPath)
        todo.isDone.toggle()
        try? context.save()
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let context = container?.viewContext else { return }
        
        let movedTodo = fetchedResultsController.object(at: sourceIndexPath)
        let sectionIndex = destinationIndexPath.section

        let updatedTodo = TodoItem(id: movedTodo.id!,
                                    title: movedTodo.title!,
                                    isDone: movedTodo.isDone,
                                    todoDescription: movedTodo.todoDescription,
                                    priority: .init(id: Int16(sectionIndex + 1),
                                                    priority: sections[sectionIndex].rawValue))
//        _ = ManagedTodoItem.createTodoItem(of: updatedTodo, with: context)
        _ = ManagedTodoItem.updateTodoItem(currentTodoItem: movedTodo, updatedTodoItem: updatedTodo, with: context)
        try? context.save()
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let addEditTVC = AddEditTodoItemTableViewController(style: .grouped)
        addEditTVC.todoItem = fetchedResultsController.object(at: indexPath)
        addEditTVC.context = container?.viewContext
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC, animated: true, completion: nil)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController.sectionIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return fetchedResultsController.section(forSectionIndexTitle: title, at: index)
    }
}
