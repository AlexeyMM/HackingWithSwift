//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by Alexey Morozov on 15.03.2022.
//

import SwiftUI

@main
struct FriendfaceApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
