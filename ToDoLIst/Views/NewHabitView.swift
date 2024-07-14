//
//  NewHabitView.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 14/07/24.
//

import SwiftUI

struct NewHabitView: View {
    
    @State var selectedColor = Color(hex: "025315")
    var color: [Color] = [
        Color(hex: "025315"),
        Color(hex: "ba5f06"),
        Color(hex: "511eb3"),
        Color(hex: "3137a6"),
        Color(hex: "004886"),
        Color(hex: "4d1b7c"),
        Color(hex: "054d62"),
        Color(hex: "4142b9"),
        Color(hex: "2b467d"),
        Color(hex: "802a3f"),
        Color(hex: "9677b3"),
        Color(hex: "7b2018"),
        Color(hex: "b85a2e"),
        Color(hex: "b77137"),
        Color(hex: "5d21b7"),
        Color(hex: "ae0c06")
    ]
    let theme = ["Daily", "Weekly", "Monthly"]
    @State private var selectedTheme = "Daily"
    @State var habitName = ""
    @State var reminder = false 
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 16) {
                    
                        TextField("Habit Name", text: $habitName)
                            .font(.title3)
                            .bold()
                        HStack {
                            Text("Would you like to add more details?")
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Theme")
                            Picker("Please choose a color", selection: $selectedTheme) {
                                ForEach(theme, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Color")
                            LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(color, id: \.self) { color in
                                    ZStack {
                                        Button {
                                            selectedColor = color
                                        } label: {
                                            Circle()
                                                .frame(width: 38)
                                                .foregroundColor(color)
                                        }
                                        if selectedColor == color {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        }
                        
    
                        
                        Toggle("Reminder", isOn: $reminder)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    NewHabitView()
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
