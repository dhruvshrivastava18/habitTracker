//
//  WeeklyListTrackerItem.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 19/07/24.
//

import SwiftUI

struct WeeklyListTrackerItem: View {
    
    @State var int = 0
    var modal: Modal
    @State var dateArray: [Date] = []
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Constants.color[modal.paletteColor].opacity(0.6))
                            .frame(width: 40, height: 40)
                            .cornerRadius(12)
                        Constants.images[modal.image].image
                            .resizable()
                            .frame(width: 20, height:  20)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(modal.name)
                            .foregroundColor(Constants.AppWhite)
                        HStack(spacing: 0) {
                            Text("🔥")
                                .font(.caption2)
                            Text("\(modal.streak) Days")
                                .font(.caption2)
                        }
                    }
                }
                Spacer()
                Text(modal.frequency)
                    .font(.caption)
            }
            
            HStack(spacing: 2) {
                if dateArray.count == 7 {
                    ForEach(0..<7) { index in
                        WeeklyListItem(modal: modal, day: Constants.days[index], date: dateArray[index])
                    }
                }
            }
            .padding(.top)
        }
        .padding(16)
        .background {
            Rectangle()
                .fill(Constants.color[modal.paletteColor])
                .opacity(0.1)
        }
        .cornerRadius(12)
        .onAppear(perform: {
            self.dateArray = getDatesBasedOnStartStartDay(Constants.days[0])
        })
    }
    
    
}

struct WeeklyListItem: View {
    
    @Environment(\.modelContext) private var context
    
    @State var int: Int = 0
    let modal: Modal
    let day: String
    let date: Date
    
    var body: some View {
        VStack {
            Text(day)
                .font(.caption)
            Button {
                if !(date > getTodayDate()) {
                    if int < modal.dailyTotal {
                        int = int + 1
                        modal.data.updateValue(int, forKey: date)
                        try? context.save()
                    } else {
                        int = 0
                        modal.data.updateValue(int, forKey: date)
                        try? context.save()
                    }
                }
            } label: {
                if int == modal.dailyTotal  {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Constants.color[modal.paletteColor])
                } else {
                    
                    ZStack {
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Constants.color[modal.paletteColor])
                        if !(date > getTodayDate()) {
                            Text("\(int)/\(modal.dailyTotal)")
                                .font(.system(size: 8, weight: .light))
                                .foregroundStyle(Constants.AppWhite)
                        }
                    }
                }
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(date == getTodayDate() ? Constants.color[modal.paletteColor].opacity(0.2) : Color.clear)
        .cornerRadius(20)
        .onAppear(perform: {
            if let value = modal.data[date] {
                int = value
            }
        })
    }
}

//#Preview {
//    WeeklyListTrackerItem(image: Image(.dumbell), text: "Leetcode", total: 2, color: Color(hex: "9677b3"), streak: 3, frequency: "Everyday")
//}
