//
//  TaskView.swift
//  ToDo List App
//
//  Created by Eric Cartman on 07.07.2022.
//

import SwiftUI

struct TaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: TodoItem
    @EnvironmentObject var model: CoreDataTaskListVM
    @State private var addView = false
    @State private var showingAlert = false
    var body: some View {
        NavigationView {
                VStack(alignment: .center) {
                    HStack {
                        Image(systemName: "chevron.right.square.fill")
                        Text(item.title ?? "Untitled")
                            .font(.title)
                            .fontWeight(.bold)
                        Image(systemName: "chevron.left.square.fill")
                    }
                    if(item.taskArray.isEmpty) {
                        VStack {
                            Image("empty_state")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Text("No tasks here yet.")
                                .font(Font.system(size: 30, weight: .black, design: .rounded))
                        }
                    }
                    
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
                    if item.taskArray.isEmpty {
                        addTaskButton
                    }
                    else {
                        HStack {
                            deleteTasksButton
                            Spacer()
                            addTaskButton
                        }
                    }
                    Spacer()
                }
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    private var addTaskButton: some View {
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
    
    private var deleteTasksButton: some View {
        Button {
            showingAlert = true
            } label: {
                HStack {
                    Image(systemName: "trash.fill")
                    Text("Delete all")
                        .fontWeight(.bold)
                }
                .foregroundColor(.red)
            }
            .buttonStyle(GrowingButton())
            .alert("Are you sure?", isPresented: $showingAlert) {
                Button("Delete", role: .destructive) { model.deleteAllTasks(tasks: item.taskArray, context: viewContext)}
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This action will delete all you tasks")
            }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        let item = TodoItem()
        item.title = "Example"
        return TaskView(item: item)
    }
}



