//
//  ViewModel.swift
//  ToDo List App
//
//  Created by Eric Cartman on 20.07.2022.
//

import Foundation
import CoreData
import Combine
import SwiftUI


class CoreDataTaskListVM: ObservableObject {
    let manager = DataController.instance
    @Published var taskListTitle = ""
    @Published var itemTitle = ""
    @Published var listItem: TodoItem!
    @Published var taskItem: TodoTask!
    
    //MARK: - intents
    func addItem(context: NSManagedObjectContext) {
        if listItem == nil {
            let newItem = TodoItem(context: context)
            newItem.title = itemTitle
            newItem.id = UUID()
        }
        else {
            listItem.title = itemTitle
        }
        save(context: context)
        itemTitle = ""
    }
    
    func addTask(item:TodoItem, context: NSManagedObjectContext)
    {
        if taskItem == nil {
            let newTask = TodoTask(context: context)
            newTask.taskTitle = taskListTitle
            newTask.id = UUID()
            newTask.isDone = false
            item.addToTasks(newTask)
        }
        else {
            taskItem.taskTitle = taskListTitle
        }
        save(context: context)
        taskListTitle = ""
    }
    
    func save(context: NSManagedObjectContext) {
        manager.save(context: context)
    }
    
    func isDone(task: TodoTask, context: NSManagedObjectContext) {
        withAnimation {
            task.isDone.toggle()
        }
        save(context: context)
    }
    
    func editItem(item: TodoItem) {
        listItem = item
    }
    
    func editTask(task: TodoTask) {
        taskItem = task
    }
    
    func deleteItem(item: TodoItem, context: NSManagedObjectContext) {
        context.delete(item)
        save(context: context)
    }
    
    func deleteAllItems(items: FetchedResults<TodoItem>, context: NSManagedObjectContext) {
        for item in items {
            context.delete(item)
        }
        items.indices.forEach {context.delete(items[$0])}
        save(context: context)
    }
    
    func deleteAllTasks(tasks: [TodoTask], context: NSManagedObjectContext) {
        tasks.indices.forEach {context.delete(tasks[$0])}
        save(context: context)
    }
    
    func deleteTask(task: TodoTask, context: NSManagedObjectContext)
    {
        context.delete(task)
        save(context: context)
    }
}
