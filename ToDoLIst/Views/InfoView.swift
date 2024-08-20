//
//  InfoView.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 21/07/24.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.modelContext) private var context
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentDate: Date = Date()
    
    @State private var currentMonth = 0
    let modal: Modal
    
    let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        NavigationView {
            ScrollView {
                Constants.images[modal.image].image
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.top)
                Text(modal.name)
                    .fontWeight(.semibold)
                    .padding(.top)
                
                CalenderView
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Image(systemName: "flame")
                        
                        Text("\(modal.streak) Days")
                            .fontWeight(.semibold)
                        
                        Text("Current Streak")
                            .font(.caption2)
                    }
                    .padding(.leading)
                    Spacer()
                }
                .padding(.vertical)
                .foregroundColor(Color(hex: "7fdb7c"))
                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width)
                .background(Color(hex: "093312"))
                .cornerRadius(16)
                .padding(.horizontal)
                HStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Image(.rocket)
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(hex: "7fdb7c"))
                            
                            Text("\(findLongestStreak(modal.data, dailyTotal: modal.dailyTotal)) Days")
                                .fontWeight(.semibold)
                            
                            Text("Longest Streak")
                                .font(.caption2)
                        }
                        .padding(.leading)
                        Spacer()
                    }
                    .padding(.vertical)
                  
                    .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width)
                    .overlay(
                           RoundedRectangle(cornerRadius: 16)
                               .stroke(Color(hex: "093312"), lineWidth: 1)
                       )
                 
            
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color(hex: "7fdb7c"))
                            
                            Text("\(findTotalDaysCompleted(modal.data, dailyTotal: modal.dailyTotal)) Days")
                                .fontWeight(.semibold)
                            
                            Text("Total Completed")
                                .font(.caption2)
                        }
                        .padding(.leading)
                        Spacer()
                    }
                    .padding(.vertical)
              
                    .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width)
                    .overlay(
                           RoundedRectangle(cornerRadius: 16)
                               .stroke(Color(hex: "093312"), lineWidth: 1)
                       )
           
                    
                }
                .padding(.horizontal)
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        deleteItem(modal)
                        dismiss()
                    } label: {
                        Image(systemName: "trash.fill")
                            .foregroundStyle(Constants.AppWhite)
                    }
                    
                    NavigationLink {
                        NewHabitView(modal: modal, isEdit: true)
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundStyle(Constants.AppWhite)
                    }
                    
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Constants.AppWhite)
                    }
                }
            }
        }
    }
    
    var CalenderView: some View {
        VStack(spacing: 35) {
            
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(extraDateData()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(extraDateData()[1])
                        .font(.title.bold())
                }
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Button {
                    currentMonth += 1
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            HStack(spacing: 0) {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(extractDate()) { value in
                        CardView(value: value)
                    }
                }
            }
        }
        .onChange(of: currentMonth) { oldValue, newValue in
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
            }
        }
    }
    
    private func deleteItem(_ item: Modal) {
        context.delete(item)
    }
    
    private func extractDate() -> [DateValue] {
        let calender = Calendar.current

        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calender.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        let firstWeekDay = calender.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekDay - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
        
    }
    
    private func getCurrentMonth() -> Date {
        let calender = Calendar.current
        
        guard let currentMonth = calender.date(byAdding: .month, value: self.currentMonth, to: Date())
        else {
            return Date()
        }
        
        return currentMonth
    }
    
    private func extraDateData() -> [String] {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
}

#Preview {
    InfoView(modal: Modal.init(name: "sdf", color: 2, image: 2, dailyTotal: 1, streak: 2, frequency: "ewf", dailyData: [:]))
}

