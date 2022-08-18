//
//  ItemListCell.swift
//  ToDo List App
//
//  Created by Eric Cartman on 11.08.2022.
//

import SwiftUI

struct ItemListCell: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var model:CoreDataTaskListVM
    @ObservedObject var item: TodoItem
    @State private var isEdit = false
    
    var body: some View {
        HStack {
            Text(item.title ?? "Untitled")
                .font(Font.system(size: 20, weight: .bold, design: .rounded))
            Spacer()
            Image(systemName: "figure.walk")
                .foregroundColor(.accentColor)
        }
        .sheet(isPresented: $isEdit) {
            AddListView(addView: $isEdit)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive, action: {
                model.deleteItem(item: item, context: viewContext)
            }, label: {
                Label("Delete", systemImage: "trash")
            })
            .tint(.red)
            
            Button {
                model.itemTitle = item.title ?? ""
                model.listItem = item
                isEdit.toggle()
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.yellow)
        }
    }
}

//struct ItemListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemListCell()
//            .environmentObject(CoreDataTaskListVM())
//    }
//}
