//
//  HereLive_DemoApp.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//

import SwiftUI
import Firebase

@main
struct HereLive_DemoApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
