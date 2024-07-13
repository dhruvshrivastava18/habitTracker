//
//  ContentView.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 13/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                ScrollView {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Image(.bars)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30)
                            .foregroundColor(.green)
                    }
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
