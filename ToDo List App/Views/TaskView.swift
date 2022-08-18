//
//  TaskView.swift
//  ToDo List App
//
//  Created by Eric Cartman on 07.07.2022.
//

import SwiftUI

struct TaskView: View {
    @ObservedObject var item: TodoItem
    @EnvironmentObject var model: CoreDataTaskListVM
    @State private var addView = false

    var body: some View {
        NavigationView {
                VStack(alignment: .center) {
                    Text(item.title ?? "Untitled")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    List {
                        ForEach(item.taskArray) { task in
                            TaskListCell(task: task, item: item)
                        }
                    }
                    .sheet(isPresented: $addView) {
                        AddTaskView(item: item, addView: $addView)
                    }
                    if(item.taskArray.allSatisfy{$0.isDone} && !item.taskArray.isEmpty) {
                        CheckmarkAnimation()
                            .padding(.bottom, 260)
                    }
                    addTaskButton
                    Spacer()
                }
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    var addTaskButton: some View {
        Button(action: {
            model.taskListTitle = ""
            model.taskItem = nil
            addView.toggle()
        }, label: {
            Label("Add task", systemImage: "plus")
        })
        .buttonStyle(GrowingButton())
        .foregroundColor(.blue)
    }
    
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        let item = TodoItem()
        item.title = "Example"
        return TaskView(item: item)
    }
}



