//
//  Todo.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/01/07.
//

import Foundation

struct TodoItem: Hashable {
    let id: UUID
    let title: String
    var isDone: Bool
    let todoDescription: String?
    let priority: Priority

    struct Priority {
        let id: Int16
        let priority: String
        
        enum PType: String {
            case high = "High"
            case middle = "Middle"
            case low = "Low"
        }
    }
    
    static func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
        print(lhs.id.uuidString == rhs.id.uuidString)
        return lhs.id.uuidString == rhs.id.uuidString
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
