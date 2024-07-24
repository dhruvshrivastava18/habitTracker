//
//  NewHabitView.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 14/07/24.
//

import SwiftUI

struct NewHabitView: View {
    
    @Environment(\.modelContext) private var context
    
    @State var selectedColor = Color(hex: "025315")
    @State var selectedImage = Constants.images[0]
    
    @State private var selectedFrequency = "Daily"
    @State var habitName = ""
    @State var reminder = false 
    @State var int = 0
    @State var selectedDays: [String] = []
    @State var selectedDates: [String] = []
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Constants.pickerGreen)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Constants.AppBlack)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Constants.AppWhite)], for: .normal)
    }
    
    var body: some View {
//        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                    
                        // Habit Name
                        TextField("Habit Name", text: $habitName)
                            .font(.title3)
                            .bold()
                        HStack {
                            Text("Would you like to add more details?")
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        
                        // Frequency Selector
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Theme")
                            Picker("Please choose a color", selection: $selectedFrequency) {
                                ForEach(Constants.frequency, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                            
                        }
                        
                        RepeatView(selectedFrequency: selectedFrequency)
                        
                        // Color Selection
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Color")
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(Constants.color, id: \.self) { color in
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
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Icon")
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(Constants.images) { image in
                                    Button {
                                        selectedImage = image
                                    } label: {
                                        ZStack {
                                            if selectedImage == image {
                                                Rectangle()
                                                    .fill(Constants.grayBackground)
                                                    .frame(width: 35, height: 35)
                                                    .cornerRadius(4)
                                                    .overlay(
                                                        
                                                        RoundedRectangle(cornerRadius: 4)
                                                            .stroke(.green, lineWidth: 1)
                                                        
                                                    )
                                            } else {
                                                Rectangle()
                                                    .fill(Constants.grayBackground)
                                                    .frame(width: 35, height: 35)
                                                    .cornerRadius(4)
                                            }
                                            
                                            image.image
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                        }
                                    }
                                }
                            }
                        }
                        
                        // Reminder
                        Toggle("Reminder", isOn: $reminder)
                            .padding(.trailing, 4)
                        
                        // Goal 
                        HStack {
                            Text("Goal")
                            Spacer()
                            HStack {
                                Button {
                                    if int > 0 {
                                        int = int - 1
                                    }
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Constants.grayBackground)
                                            .frame(width: 24, height: 24)
                                            .cornerRadius(4)
                                            .cornerRadius(6, corners: [.topLeft, .bottomLeft])
                                        Image(systemName: "minus")
                                            .foregroundColor(Constants.pickerGreen)
                                    }
                                }
                                
                                HStack(alignment: .bottom) {
                                    Text("\(int) /")
                                    Text("Day")
                                        .font(.caption)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Constants.selectedTabColor)
                                .cornerRadius(6)
                                
                                Button {
                                    int = int + 1
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Constants.grayBackground)
                                            .frame(width: 24, height: 24)
                                            .cornerRadius(6, corners: [.topRight, .bottomRight])
                                        Image(systemName: "plus")
                                            .foregroundColor(Constants.pickerGreen)
                                    }
                                }
                            }
                        }
                        
                    }
                    .padding(.top)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Save")
                            .foregroundColor(Constants.AppGreen)
                    }
                    .buttonStyle(.plain)
                    .disabled(true)
                }
                ToolbarItem(placement: .topBarLeading) {
                    
                }
            })
            .onAppear(perform: {
                selectedDays = Constants.days
            })
            .navigationBarBackButtonHidden()
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, 16)
//        }
    }
    
    
    private func RepeatView(selectedFrequency: String) -> some View {
        VStack {
            
            if selectedFrequency != Constants.frequency[2] {
                HStack {
                    Text("On these days")
                    Spacer()
                    HStack {
                        if selectedDays.count != 7 {
                            Text(selectedDays.joined(separator: ", "))
                                .font(.caption)
                        } else {
                            Text("Everyday")
                                .font(.caption)
                        }
                    }
                    .multilineTextAlignment(.leading)
                }
                HStack(spacing: 4) {
                    ForEach(Constants.days, id: \.self) { day in
                        DayTabView(selectedDays: $selectedDays, isSelected: selectedDays.contains(day), day: day)
                    }
                }
            } else {
                VStack {
                    HStack {
                        Spacer()
                        if !selectedDates.isEmpty {
                            Text("Every month on ")
                                .font(.caption)
                            
                            +
                            Text(selectedDates.joined(separator: ", "))
                                .font(.caption)
                        } else {
                            Text("Dummy Text")
                                .font(.caption)
                                .hidden()
                        }
                        
                    }
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 30, maximum: 50)), count: 7), content: {
                        ForEach(1...31, id: \.self) { date in
                            MonthTabView(selectedDates: $selectedDates, isSelected: selectedDates.contains("\(date)"), date: "\(date)")
                        }
                    })
                }
                
            }
        }
    }
}

struct DayTabView: View {
    @Binding var selectedDays: [String]
    var isSelected: Bool
    var day: String
    var body: some View {
        Button {
            if let index = selectedDays.firstIndex(of: day) {
                selectedDays.remove(at: index)
            } else {
                selectedDays.append(day)
            }
        } label: {
            Text(day)
                .foregroundColor(Constants.AppWhite)
                .font(.caption)
                .frame(width: 50, height: 20)
                .background(isSelected ? Constants.selectedTabColor : Constants.grayBackground)
                .cornerRadius(6)
        }
    }
}

struct MonthTabView: View {
    @Binding var selectedDates: [String]
    var isSelected: Bool
    var date: String
    var body: some View {
        Button {
            if let index = selectedDates.firstIndex(of: date) {
                selectedDates.remove(at: index)
            } else {
                selectedDates.append(date)
            }
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(isSelected ? Constants.selectedTabColor : .clear)
                Text("\(date)")
                    .font(.caption)
                    .foregroundColor(Constants.AppWhite)
            }
        }
    }
}

#Preview {
    NewHabitView()
}

