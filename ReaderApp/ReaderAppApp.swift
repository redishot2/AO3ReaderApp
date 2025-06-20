//
//  ReaderAppApp.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 3/2/25.
//

import SwiftUI

@main
struct ReaderAppApp: App {
    
    @State var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
