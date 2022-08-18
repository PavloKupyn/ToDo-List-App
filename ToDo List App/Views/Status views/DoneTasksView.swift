//
//  DoneTasksView.swift
//  ToDo List App
//
//  Created by Eric Cartman on 17.08.2022.
//

import SwiftUI

struct DoneTasksView: View {
    @FetchRequest(entity: TodoItem.entity(), sortDescriptors: [NSSortDescriptor(key: "id", ascending: true)]) var fetchedTaskList: FetchedResults<TodoItem>
    
    var body: some View {
        VStack {
            List {
                if (fetchedTaskList.isEmpty || fetchedTaskList.allSatisfy{$0.taskArray.isEmpty} || fetchedTaskList.allSatisfy{$0.taskArray.allSatisfy{!$0.isDone}}) {
                    emptyStatus
                }
                ForEach(fetchedTaskList) { item in
                    if(item.taskArray.allSatisfy{$0.isDone} && !item.taskArray.isEmpty) {
                        Section(item.title!) {
                            Text("All tasks are done!")
                        }
                    }
                    else if(item.taskArray.allSatisfy{!$0.isDone}) {
                        EmptyView()
                    }
                    else {
                        Section(item.title!) {
                            ForEach(item.taskArray.filter{$0.isDone}) { task in
                                TaskListCell(task: task, item: item)
                            }
                        }
                    }
                }
            }
        }
    }
}

var emptyStatus: some View {
    VStack {
        Text("Nothing to see here yet.")
            .font(.title)
            .fontWeight(.black)
            .multilineTextAlignment(.center)
        .padding(.leading, 20)
        Image("dudes")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct DoneTasksView_Previews: PreviewProvider {
    static var previews: some View {
        DoneTasksView()
            .preferredColorScheme(.dark)
    }
}
