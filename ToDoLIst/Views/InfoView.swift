//
//  InfoView.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 21/07/24.
//

import SwiftUI
import Fastis

struct InfoView: View {
    
    @State private var selectedDate: Date = Date()
    
    var title: String
    var image: Image
    
    var body: some View {
        NavigationView {
            ScrollView {
                image
                    .resizable()
                    .frame(width: 25, height: 25)
                Text(title)
                
                
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "")
                }
            }
        }
    }
}

#Preview {
    InfoView(title: "Week Test", image: Image(.dumbell))
}
