//
//  ContentView.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 13/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = "Today"
    
    
    var body: some View {
        NavigationView {
            VStack() {
                TopTabView
                ScrollView {
                    DailyListTrackerItem(image: Image(.dumbell), text: "Leetcode", total: 2, color: Color(hex: "9677b3"), streak: 3)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .overlay(alignment: .bottomTrailing) {
                    NavigationLink {
                        NewHabitView()
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 50)
                                .foregroundColor(Constants.settingsButtonColor)
                            Image(systemName: "plus")
                                .foregroundColor(Constants.AppWhite)
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
                            .foregroundColor(Constants.settingsButtonColor)
                    }
                }
            })
        }
    }
    
    var TopTabView: some View {
        HStack(spacing: 16) {
            ForEach(Constants.tabs, id: \.self) { text in
                if selection == text {
                    Text(text)
                        .padding(8)
                        .padding(.horizontal, 4)
                        .background(Constants.selectedTabColor)
                        .clipShape(.capsule)
                        .foregroundColor(Constants.pickerGreen)
                } else {
                    Button {
                        withAnimation(.linear) {
                            selection = text
                        }
                    } label: {
                        Text(text)
                            .padding(8)
                            .padding(.horizontal, 4)
                            .foregroundColor(Constants.AppWhite)
                            .opacity(0.6)
                    }
                }
            }
            Spacer()
        }
        .padding([.leading, .top])
    }
}



#Preview {
    ContentView()
//    DailyListTracker(image: Image(.dumbell), text: "Text")
}
