//
//  ManagedTodoItem.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/02/18.
//

import Foundation
import CoreData

public class ManagedTodoItem: NSManagedObject {
    
    class func fetcheTodoItems(in context: NSManagedObjectContext) throws -> [ManagedTodoItem]? {
        let request: NSFetchRequest<ManagedTodoItem> = ManagedTodoItem.fetchRequest()
        return try? context.fetch(request)
    }
    
    class func createTodoItem(of todo: TodoItem, with context: NSManagedObjectContext) -> ManagedTodoItem{
        let newTodo = ManagedTodoItem(context: context)
        newTodo.id = UUID()
        newTodo.isDone = todo.isDone
        newTodo.priority = try? ManagedPriority.findOrCreatePriority(matching: todo.priority, in: context)
        newTodo.title = todo.title
        newTodo.todoDescription = todo.todoDescription
        
        return newTodo
    }
    
    class func updateTodoItem(currentTodoItem: ManagedTodoItem, updatedTodoItem: TodoItem, with context: NSManagedObjectContext) -> ManagedTodoItem {
        currentTodoItem.id = updatedTodoItem.id
        currentTodoItem.isDone = updatedTodoItem.isDone
        currentTodoItem.priority = try? ManagedPriority.findOrCreatePriority(matching: updatedTodoItem.priority, in: context)
        currentTodoItem.title = updatedTodoItem.title
        currentTodoItem.todoDescription = updatedTodoItem.todoDescription
        
        return currentTodoItem
    }
}
