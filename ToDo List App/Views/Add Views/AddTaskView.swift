//
//  AddTaskView.swift
//  ToDo List App
//
//  Created by Eric Cartman on 17.08.2022.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var model: CoreDataTaskListVM
    @ObservedObject var item: TodoItem
    @Binding var addView: Bool
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    TextField("Enter Title", text: $model.taskListTitle)
                    Button {
                        model.addTask(item: item, context: viewContext)
                        addView.toggle()
                    } label: {
                        if model.taskItem == nil {
                            Text("Add Task")
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        else {
                            Text("Edit Task")
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                    .tint(.green)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                }
            }
            .navigationTitle(model.taskItem == nil ? "Add Task": "Edit")
        }
    }
}

//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskView()
//    }
//}
