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
    @State private var showingAlert =  false
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack {
                    doneSection
                    inProgressSection
                }
                if (fetchedTaskList.isEmpty) {
                    Image("darts")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding([.top, .trailing, .bottom], 20)
                    HStack {
                        Image(systemName: "hourglass.bottomhalf.filled")
                            .foregroundColor(.blue)
                        Text("get them tasks done")
                            .font(.title)
                            .fontWeight(.bold)
                        Image(systemName: "hourglass.tophalf.filled")
                            .foregroundColor(.blue)
                    }
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
                if fetchedTaskList.isEmpty {
                    EmptyView()
                }
                else {
                    deleteButton
                }
                Spacer()
            }
            .navigationBarTitle("ToDo list", displayMode: .inline)
        }
    }
    
    var deleteButton: some View {
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
                Button("Delete", role: .destructive) { model.deleteAllItems(items: fetchedTaskList, context: viewContext)}
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This action will delete all you items")
            }
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
