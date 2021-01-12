//
//  Todo.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/07.
//

import Foundation

struct TodoItem: Equatable {
    let title: String
    var checkMark: String
    let todoDescription: String?
    let priorityNumber: Int
    
    static func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
        return lhs.title == rhs.title &&
            lhs.checkMark == rhs.checkMark &&
            lhs.todoDescription == rhs.todoDescription &&
            lhs.priorityNumber == rhs.priorityNumber
    }
}
