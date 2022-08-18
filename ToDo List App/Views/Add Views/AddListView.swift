//
//  AddListView.swift
//  ToDo List App
//
//  Created by Eric Cartman on 11.08.2022.
//

import SwiftUI

struct AddListView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var model: CoreDataTaskListVM
    @Binding var addView: Bool
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    TextField("Enter Title", text: $model.itemTitle)
                    Button {
                        model.addItem(context: viewContext)
                        addView.toggle()
                    } label: {
                        if model.listItem == nil {
                            Text("Add Item")
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        else {
                            Text("Edit Item")
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                    .tint(.green)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                }
            }
            .navigationTitle(model.listItem == nil ? "Add Item": "Edit")
        }
    }
}

//struct AddListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddListView(addView: false)
//    }
//}
