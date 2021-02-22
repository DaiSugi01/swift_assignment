//
//  AddEditTodoItemTableViewController.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/11.
//

import UIKit
import CoreData

protocol AddEditTodoItemTVCDelegate: class {
    func add(_ todo: TodoItem)
    func edit(_ editedTodo: TodoItem, indexPath: IndexPath)
}

class AddEditTodoItemTableViewController: UITableViewController {
    
    enum Section: String {
        case name = "Name"
        case description = "Description"
        case priority = "Priority"
    }
    
    let sections: [Section] = [.name, .description, .priority]
    
    enum PriorityNumber: String {
        case high = "High"
        case middle = "Middle"
        case low = "Low"
    }
    
    let priorities: [PriorityNumber] = [.high, .middle, .low]
    
    let nameCell = AddEditTodoItemTableViewCell()
    let descriptionCell = AddEditTodoItemTableViewCell()
    let priorityCell = AddEditTodoItemSegmentCell()
    
    var delegate: AddEditTodoItemTVCDelegate?
    weak var todoItem: ManagedTodoItem?
    var indexPath: IndexPath?
    
    lazy var saveButton = UIBarButtonItem(barButtonSystemItem: .save,
                                          target: self,
                                          action: #selector(saveTodo))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(gestureRecognizer)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        if todoItem == nil {
            title = "Add Todo"
        } else {
            title = "Edit Todo"
            nameCell.textField.text = todoItem?.title
            descriptionCell.textField.text = todoItem?.todoDescription
        }
        
        // cancel button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissViewController))
        // save button
        navigationItem.rightBarButtonItem = saveButton
        
        // textfields add target action
        nameCell.textField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        descriptionCell.textField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        
        updateSaveButtonState()
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc func saveTodo() {
        let priority = createPriority()
        
        let newTodo = TodoItem(
            id: UUID(),
            title: nameCell.textField.text!,
            isDone: false,
            todoDescription: descriptionCell.textField.text!,
            priority: priority
        )
        
        if todoItem == nil {
            delegate?.add(newTodo)
        } else {
            delegate?.edit(newTodo, indexPath: indexPath!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func createPriority() -> TodoItem.Priority {
        let selectedNumber = priorityCell.segmentControll.selectedSegmentIndex
        let id = Int16(selectedNumber + 1)
        let priority = priorities[selectedNumber]
        
        switch priority {
        case .high:
            return TodoItem.Priority(id: id, priority: priority.rawValue)
        case .middle:
            return TodoItem.Priority(id: id, priority: priority.rawValue)
        case .low:
            return TodoItem.Priority(id: id, priority: priority.rawValue)
        }
    }
    
    private func updateSaveButtonState() {
        let nameText = nameCell.textField.text ?? ""
        let descriptionText = descriptionCell.textField.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .name:
            return nameCell
        case .description:
            return descriptionCell
        case .priority:
            return priorityCell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].rawValue
    }
    
}
