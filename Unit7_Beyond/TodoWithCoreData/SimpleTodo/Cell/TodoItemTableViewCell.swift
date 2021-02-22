//
//  TodoTableViewCell.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/07.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    
    static let reusableCell = "todoItemCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let hStackView = UIStackView()
        hStackView.addArrangedSubview(checkMark)
        hStackView.addArrangedSubview(todoName)
        
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
    
    func update(with todoItem: ManagedTodoItem) {
        todoName.text = todoItem.title
        checkMark.text = todoItem.isDone ? "✓" : ""
    }
}
