//
//  ChatApp2_0App.swift
//  ChatApp2.0
//
//  Created by Shraddha on 26/03/23.
//

import SwiftUI

 @main
struct ChatApp2_0App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserSettings())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
