//
//  File.swift
//  ToDo List App
//
//  Created by Eric Cartman on 20.07.2022.
//

import Foundation
import CoreData


class DataController
{
    static let instance = DataController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "ToDo List App")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data. \(error.localizedDescription)")
            }
        }
    }
}



