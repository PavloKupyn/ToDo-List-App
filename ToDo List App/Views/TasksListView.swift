//
//  TasksListView.swift
//  ToDo List App
//
//  Created by Eric Cartman on 11.07.2022.
//

import SwiftUI

struct TasksListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var model: CoreDataTaskListVM
    @State private var addView = false
    @FetchRequest(entity: TodoItem.entity(), sortDescriptors: [NSSortDescriptor(key: "id", ascending: true)]) var fetchedTaskList: FetchedResults<TodoItem>
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack {
                    doneSection
                    inProgressSection
                }
                if (fetchedTaskList.isEmpty)
                {
                    Image("tasks")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 50)
                    Text("get them tasks done")
                        .font(.title)
                        .fontWeight(.bold)
                }
                List {
                        ForEach(fetchedTaskList) { item in
                            NavigationLink(destination: TaskView(item: item)) {
                                ItemListCell(item: item)
                                }
                            }
                        .onMove { indexSet, offset in
//                            $model.items.move(fromOffsets: indexSet, toOffset: offset)
                        }                        
                }
                .sheet(isPresented: $addView) {
                    AddListView(addView: $addView)
                }
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        addItemButton
                    }
                }
                
                deleteButton
                
                Spacer()
            }
            .navigationBarTitle("ToDo list", displayMode: .inline)
        }
    }
    
    var deleteButton: some View {
        Button {
            model.deleteAllItems(items: fetchedTaskList, context: viewContext)
            } label: {
                HStack {
                    Image(systemName: "minus.circle.fill")
                    Text("Delete all")
                        .fontWeight(.bold)
                }
                .foregroundColor(.red)
            }
            .buttonStyle(GrowingButton())
    }
    var addItemButton: some View {
        Button(action: {
            model.itemTitle = ""
            model.listItem = nil
            addView.toggle()
        }, label: {
            Label("Add Item", systemImage: "plus")
        })
        .buttonStyle(GrowingButton())
        .foregroundColor(.blue)
    }
    
    var doneSection: some View {
        NavigationLink(destination: DoneTasksView()) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 50)
                    .foregroundColor(.green)
                HStack {
                    Image(systemName: "checkmark")
                    Text("Done")
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                }
            }
        .padding(.trailing)
        }
    }

    var inProgressSection: some View {
        NavigationLink(destination: InProgressView()) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 140, height: 50)
                    .foregroundColor(.yellow)
                HStack {
                    Image(systemName: "clock")
                    Text("In progress")
                        .fontWeight(.black)
                }
                .foregroundColor(.black)
            }
        }
        .padding(.leading)
    }


struct TasksListView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView()
            .environmentObject(CoreDataTaskListVM())
            .preferredColorScheme(.dark)
    }
}
