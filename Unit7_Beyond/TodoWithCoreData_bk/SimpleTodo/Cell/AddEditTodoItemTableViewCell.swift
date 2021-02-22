//
//  AddEditTodoItemTableViewCell.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/11.
//

import UIKit

class AddEditTodoItemTableViewCell: UITableViewCell {

    let textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(textField)
        textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
