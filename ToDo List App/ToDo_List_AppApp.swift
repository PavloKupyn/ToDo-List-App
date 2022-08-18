//
//  ToDo_List_AppApp.swift
//  ToDo List App
//
//  Created by Eric Cartman on 06.07.2022.
//

import SwiftUI

@main
struct ToDo_List_AppApp: App {
    @StateObject private var model = CoreDataTaskListVM()
    let dataController = DataController.instance

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
