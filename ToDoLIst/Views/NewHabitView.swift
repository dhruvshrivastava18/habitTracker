//
//  NewHabitView.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 14/07/24.
//

import SwiftUI

struct NewHabitView: View {
    var color: [Color] = 
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewHabitView()
}
