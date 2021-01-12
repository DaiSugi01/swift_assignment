//
//  TodoTableViewCell.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/07.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {

    var checkMark: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 30)
        lb.setContentHuggingPriority(.required, for: .horizontal)
        return lb
    }()
    
    var todoName: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 20)
        return lb
    }()
    
    let infoIcon: UIButton = {
        let button = UIButton(type: .infoLight)
        return button
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let hStackView = UIStackView()
        hStackView.addArrangedSubview(checkMark)
        hStackView.addArrangedSubview(todoName)
        hStackView.addArrangedSubview(infoIcon)

        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.distribution = .fill
        hStackView.alignment = .fill
        hStackView.spacing = 10
        
        contentView.addSubview(hStackView)
        hStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    @objc func navigateTo(_ sender: UITableViewCell) {
        let editTVC = AddEditTodoItemTableViewController()
    }
    
    func update(with todoItem: TodoItem) {
        todoName.text = todoItem.title
        if checkMark.text == "" {
            checkMark.text = "✓"
        } else {
            checkMark.text = ""
        }
    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        self.accessoryType = selected ? .checkmark : .none
//    }
}
