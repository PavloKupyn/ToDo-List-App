//
//  TaskListCell.swift
//  ToDo List App
//
//  Created by Eric Cartman on 11.08.2022.
//

import SwiftUI

struct TaskListCell: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var model:CoreDataTaskListVM
    @ObservedObject var task: TodoTask
    @ObservedObject var item: TodoItem
    @State private var isEdit = false
    
    var body: some View {
        HStack {
            Text(task.taskTitle ?? "Untitled")
                .opacity(task.isDone ? 0.5 : 1)
            Spacer()
            Button {
                model.isDone(task: task, context: viewContext)
            } label: {
                Image(systemName: !task.isDone ? "circle" : "checkmark.circle")
                    .foregroundColor(task.isDone ? Color.green : Color.black)
            }
            .tint(.green)
        }
        .sheet(isPresented: $isEdit) {
            AddTaskView(item: item, addView: $isEdit)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive, action: {
                model.deleteTask(task: task, context: viewContext)
            }, label: {
                Label("Delete", systemImage: "trash")
            })
            .tint(.red)
            
            Button {
                model.taskListTitle = task.taskTitle ?? ""
                model.taskItem = task
                isEdit.toggle()
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.yellow)
        }
    }
}
//struct TaskListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskListCell()
//            .environmentObject(CoreDataTaskListVM())
//    }
//}
