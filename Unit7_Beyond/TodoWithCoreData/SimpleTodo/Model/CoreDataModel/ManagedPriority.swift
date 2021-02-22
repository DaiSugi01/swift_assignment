//
//  ManagedPriority.swift
//  SimpleTodo
//
//  Created by 杉原大貴 on 2021/02/21.
//

import Foundation
import CoreData

public class ManagedPriority: NSManagedObject {
    
    class func getAllPriority(in context: NSManagedObjectContext) -> [ManagedPriority]? {
        let request: NSFetchRequest<ManagedPriority> = ManagedPriority.fetchRequest()
        return try? context.fetch(request)
    }
    
    
    
    class func findOrCreatePriority(matching priorityInfo: TodoItem.Priority, in context: NSManagedObjectContext) throws -> ManagedPriority? {
        let request: NSFetchRequest<ManagedPriority> = ManagedPriority.fetchRequest()
        request.predicate = NSPredicate(format: "id = %ld", priorityInfo.id)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "ManagedPriority.findOrCreatePriority -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        // no match, instantiate ManagedSource
        let priority = ManagedPriority(context: context)
        priority.id = priorityInfo.id
        priority.priority = priorityInfo.priority
                
        return priority
    }
}
