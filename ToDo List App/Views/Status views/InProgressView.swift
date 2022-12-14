//
//  InProgressView.swift
//  ToDo List App
//
//  Created by Eric Cartman on 17.08.2022.
//

import SwiftUI

struct InProgressView: View {
    @FetchRequest(entity: TodoItem.entity(), sortDescriptors: [NSSortDescriptor(key: "id", ascending: true)]) var fetchedTaskList: FetchedResults<TodoItem>
    
    var body: some View {
        VStack {
            List {
                if (fetchedTaskList.isEmpty || fetchedTaskList.allSatisfy{$0.taskArray.isEmpty} || fetchedTaskList.allSatisfy{$0.taskArray.allSatisfy{$0.isDone}}) {
                    emptyStateStatus
                }
                ForEach(fetchedTaskList) { item in
                    if(item.taskArray.allSatisfy{!$0.isDone} && !item.taskArray.isEmpty) {
                        Section(item.title!) {
                            Text("All tasks are in progress..")
                        }
                    }
                    else if(item.taskArray.allSatisfy{$0.isDone}) {
                        EmptyView()
                    }
                    else {
                        Section(item.title!) {
                            ForEach(item.taskArray.filter{!$0.isDone}) { task in
                                TaskListCell(task: task, item: item)
                            }
                        }
                    }
                }
            }
        }
    }
}


struct InProgressView_Previews: PreviewProvider {
    static var previews: some View {
        InProgressView()
    }
}
