//
//  ToDoLIstApp.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 13/07/24.
//

import SwiftUI
import SwiftData

@main
struct ToDoLIstApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Modal.self )
    }
}
