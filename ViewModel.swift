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
    @Published var items: [TodoItem] = []
    @Published var taskListTitle = ""
    @Published var itemTitle = ""
    @Published var listItem: TodoItem!
    @Published var taskItem: TodoTask!
    
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
        do {
            try context.save()
        } catch let error {
            print("Error saving Core Data \(error.localizedDescription)")
        }
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
    func deleteTask(task: TodoTask, context: NSManagedObjectContext)
    {
        context.delete(task)
        save(context: context)
    }
}
