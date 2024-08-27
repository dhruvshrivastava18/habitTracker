//
//  ContentView.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 13/07/24.
//

import SwiftUI
import SwiftData
import CoreData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var items: [Modal]
    
    @State var selection = "Today"
    
    var body: some View {
        NavigationView {
            VStack {
                TopTabView
                ScrollView {
                    if selection == Constants.tabs[0] {
                        ForEach(items) { item in
                            if checkIfToShowToday(modal: item) {
                                DailyListTrackerItem(modal: item)
                            }
                        }
                    } else if selection == Constants.tabs[1] {
                        ForEach(items) { item in
                            WeeklyListTrackerItem(modal: item)
                        }
                    } else {
                        ForEach(items) { item in
                            OverAllListTrackerItem(modal: item)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .overlay(alignment: .bottomTrailing) {
                    NavigationLink {
                        NewHabitView(modal: Modal(name: "", color: 0, image: 0, dailyTotal: 0, streak: 0, frequency: "", dailyData: [:]), isEdit: false)
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
                            .navigationBarBackButtonHidden()
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
    
    func checkIfToShowToday(modal: Modal) -> Bool {
        let today = getTodayDate()

        print(modal.frequency)
        // Get the current calendar
        let calendar = Calendar.current

        // Extract the components (year, month, day, weekday) from today's date
        let components = calendar.dateComponents([.year, .month, .day, .weekday], from: today)

        // Format the date to a readable string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // Extract the weekday name
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: today)

        if let year = components.year, let month = components.month, let day = components.day {
            if modal.frequency.contains("\(day)") || modal.frequency.contains("\(dayOfWeek.prefix(2))") || modal.frequency == "Everyday" {
                return true
            }
        }
        
        return false
    }
    
//    private func addItem() {
//        let item = Modal(name: "Pehla")
//        context.insert(item)
//    }
//    
//    private func deleteItem(_ item: Modal) {
//        context.delete(item)
//    }
//    
//    private func updateItem(_ item: Modal) {
//        item.name = "Updated Data"
//        
//        try? context.save()
//    }
}



#Preview {
    ContentView()
 
}
