//
//  TodoTableViewCell.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/10.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    let todoNameLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 20)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(todoNameLabel)
        todoNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        todoNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        todoNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        todoNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        self.accessoryType = selected ? .checkmark : .none
//    }
}
