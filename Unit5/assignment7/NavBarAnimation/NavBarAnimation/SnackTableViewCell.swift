//
//  SnackTableViewCell.swift
//  NavBarAnimation
//
//  Created by 杉原大貴 on 2021/01/15.
//

import UIKit

class SnackTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func update(with snackName: String) {
        textLabel?.text = snackName
    }
}
