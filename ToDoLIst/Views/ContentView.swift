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
                            DailyListTrackerItem(modal: item)
                        }
                    } else if selection == Constants.tabs[1] {
                        ForEach(items) { item in
                            WeeklyListTrackerItem(modal: item)
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
                
//                List {
//                    ForEach(items) { item in
//                        Text(item.name)
//                            .foregroundStyle(.white)
//                    }
//                    .onDelete { indexes in
//                        for index in indexes {
//                            deleteItem(items[index])
//                        }
//                    }
//                }
                
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
