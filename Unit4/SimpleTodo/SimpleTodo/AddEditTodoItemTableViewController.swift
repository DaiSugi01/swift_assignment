//
//  AddEditTodoItemTableViewController.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/11.
//

import UIKit


protocol AddEditTodoItemTVCDelegate: class {
  func add(_ todo: TodoItem)
  func edit(_ todo: TodoItem)
}

class AddEditTodoItemTableViewController: UITableViewController {
    
    let sectionHeaders = ["Name", "Description"]
    lazy var saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTodo))
    
    let nameCell = AddEditTodoItemTableViewCell()
    let descriptionCell = AddEditTodoItemTableViewCell()
    
    weak var delegate: AddEditTodoItemTVCDelegate?
    
    var todoItem: TodoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let newTodo = TodoItem(title: nameCell.textField.text!, checkMark: "", todoDescription: descriptionCell.textField.text!, priorityNumber: 1)
        if todoItem == nil {
          delegate?.add(newTodo)
        } else {
          delegate?.edit(newTodo)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func updateSaveButtonState() {
      let nameText = nameCell.textField.text ?? ""
      let descriptionText = descriptionCell.textField.text ?? ""
      saveButton.isEnabled = !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath {
        case [0, 0]:
            return nameCell
        case [1, 0]:
            return descriptionCell
        default:
            fatalError("Invalid number of cells")
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
 
}
