//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Felix Lunzenfichter on 11.11.20.
//

import SwiftUI
import Firebase

@main
struct TodoAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
