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
                    emptyStateStatus
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

var emptyStateStatus: some View {
    
    VStack {
        Image(systemName: "book.closed.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .padding([.bottom, .top], 20)
        VStack {
            Text("Nothing to see here yet.")
                .font(Font.system(size: 30, weight: .black, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.leading, 20)
            Spacer()
            Image("empty_state")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
       
    }
}

struct DoneTasksView_Previews: PreviewProvider {
    static var previews: some View {
        DoneTasksView()
            .preferredColorScheme(.dark)
    }
}
