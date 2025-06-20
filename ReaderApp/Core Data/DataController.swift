//
//  DataController.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 6/19/25.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ReadingHistory")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data Error: \(error.localizedDescription)")
            }
        }
    }
}
