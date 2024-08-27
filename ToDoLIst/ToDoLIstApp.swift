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
    let modelContainer: ModelContainer
    
    @Environment(\.colorScheme) var systemScheme
    
    @StateObject var colorScheme = ColorSchemea.shared
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Modal.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if let scheme = UserDefaults.standard.object(forKey: Constants.scheme) as? String {
                
                ContentView()
                    .preferredColorScheme(scheme != Constants.systemScheme ? colorScheme.colorScheme : nil)
                
            } else {
                ContentView()
            }
        }
        .modelContainer(modelContainer)
    }
}

class ColorSchemea: ObservableObject {
    static let shared = ColorSchemea()
    @Published var colorScheme = ColorScheme.light
    
    func setScheme(scheme: String) {
        UserDefaults.standard.setValue(scheme, forKey: Constants.scheme)

    }
}
