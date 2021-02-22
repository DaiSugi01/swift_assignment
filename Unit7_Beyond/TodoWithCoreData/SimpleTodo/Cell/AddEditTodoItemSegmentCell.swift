//
//  AddEditTodoItemSegmentCell.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/02/21.
//

import UIKit

class AddEditTodoItemSegmentCell: UITableViewCell {
    
    let segmentControll: UISegmentedControl = {
        let items = ["High", "Middle", "Low"]
        let sg = UISegmentedControl(items: items)
        sg.selectedSegmentIndex = 1
        return sg
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray6
        
        contentView.addSubview(segmentControll)
        
        let segWidth: CGFloat = contentView.frame.width * 0.9
        let segHeight: CGFloat = 50
        segmentControll.frame = .init(x: contentView.frame.width / 2 - segWidth / 3,
                                      y: contentView.frame.height / 2 - (segHeight / 2),
                                      width: segWidth,
                                      height: segHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
