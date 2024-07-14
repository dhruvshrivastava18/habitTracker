//
//  ContentView.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 13/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = "Today"
    var arr = ["Today", "Weekly", "Overall"]
    
    var body: some View {
        NavigationView {
            VStack() {
                TopTabView
                ScrollView {
                    DailyListTracker(image: Image(.dumbell), text: "Leetcode")
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 50)
                                .foregroundColor(.green)
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        SettingsView()
                            .tint(.green)
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
    
    var TopTabView: some View {
        HStack(spacing: 16) {
            ForEach(arr, id: \.self) { text in
                if selection == text {
                    Text(text)
                        .padding(8)
                        .padding(.horizontal, 4)
                        .background(.green)
                        .clipShape(.capsule)
                        .foregroundColor(.white)
                } else {
                    Button {
                        withAnimation(.linear) {
                            selection = text
                        }
                    } label: {
                        Text(text)
                            .padding(8)
                            .padding(.horizontal, 4)
                            .foregroundColor(.white)
                    }
                }
            }
            Spacer()
        }
        .padding([.leading, .top])
    }
}

struct DailyListTracker: View {
    var image: Image
    var text: String
    
    var body: some View {
        Button {
            
        } label: {
            HStack {
                HStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.purple)
                            .frame(width: 40, height: 40)
                            .cornerRadius(12)
                        image
                            .resizable()
                            .frame(width: 20, height:  20)
                    }
                    Text(text)
                        .foregroundColor(.white)
                }
                Spacer()
                VStack {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Text("0/2")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
            .padding(16)
            .background {
                Rectangle()
                    .fill(.brown)
                    .opacity(0.1)
            }
            .cornerRadius(12)
        }
    }
}

#Preview {
    ContentView()
//    DailyListTracker(image: Image(.dumbell), text: "Text")
}
