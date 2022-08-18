//
//  TodoItem+CoreDataProperties.swift
//  ToDo List App
//
//  Created by Eric Cartman on 25.07.2022.
//
//

import Foundation
import CoreData


extension TodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var tasks: Set<TodoTask>?
    
    public var taskArray: [TodoTask] {
        let setOfTask = tasks as? Set<TodoTask> ?? []
        
        return setOfTask.sorted {
            $0.id > $1.id
        }
    }
    
    
}

// MARK: Generated accessors for tasks
extension TodoItem {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: TodoTask)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: TodoTask)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension TodoItem : Identifiable {

}
