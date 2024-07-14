//
//  SettingsView.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 13/07/24.
//

import SwiftUI

struct SettingsView: View {
    
    let theme = ["System", "Light", "Dark"]
    @State private var selectedTheme = "System"
    
    let startDays = ["Saturday", "Sunday", "Monday"]
    @State private var selectedDay = "Saturday"
    
    @State var sounds = false
    
    @State var showCurrentStreak = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Theme")
                        Picker("Please choose a color", selection: $selectedTheme) {
                            ForEach(theme, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Week Start On")
                        Picker("Please choose a color", selection: $selectedDay) {
                            ForEach(startDays, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Toggle("Sounds", isOn: $sounds)
                    
                    Toggle("Show Current Streak", isOn: $showCurrentStreak)
                    
                    VStack(spacing: 20) {
                        SettingsOptions(image: Image(systemName: "star.fill"), text: "Rate The App")
                        SettingsOptions(image: Image(.shareNodes), text: "Share with friends")
                        SettingsOptions(image: Image(.messageBubble), text: "Send Feedback")
                        SettingsOptions(image: Image(.lock), text: "Privacy Policy")
                        SettingsOptions(image: Image(.person), text: "Terms of Service")
                    }
                    .padding(.top, 24)
                    
                }
            }
            .padding(.horizontal, 16)
            .padding(.top)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .tint(.green)
    }
}

struct SettingsOptions: View {
    var image: Image
    var text: String
    var body: some View {
        Button {
            
        } label: {
            HStack {
                ZStack {
                    Rectangle()
                        .frame(width: 30, height: 30)
                        .cornerRadius(12)
                        .foregroundColor(Color(uiColor: .darkGray))
                    image
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                
                Text(text)
                    .font(.subheadline)
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 10, height: 15)
            }
            .padding(.horizontal, 16)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SettingsView()
//    SettingsOptions(image: Image(systemName: "star.fill"), text: "Rate The App")
}
