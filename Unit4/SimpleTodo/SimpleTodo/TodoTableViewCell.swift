//
//  TodoTableViewCell.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/07.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    let todoName = UILabel()
    let checkButton = UIButton()
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        vStackView.alignment = .center
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}
