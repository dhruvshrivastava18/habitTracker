//
//  OverAllListTrackerItem.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 20/07/24.
//

import SwiftUI

struct OverAllListTrackerItem: View {
    @Environment(\.modelContext) private var context
    @State var int = 0
    
    let modal: Modal
    
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
                VStack {
                    Button {
                        if int < modal.dailyTotal {
                            int = int + 1
                            let today = getTodayDate()
                            modal.data.updateValue(int, forKey: today)
                            try? context.save()
                        } else {
                            int = 0
                            let today = getTodayDate()
                            modal.data.updateValue(int, forKey: today)
                            try? context.save()
                        }
                    } label: {
                        if int == modal.dailyTotal {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Constants.color[modal.paletteColor])
                        } else {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Constants.color[modal.paletteColor].opacity(0.6))
                        }
                    }
                    if int != modal.dailyTotal {
                        Text("\(int)/\(modal.dailyTotal)")
                            .font(.caption)
                            .foregroundColor(Constants.color[modal.paletteColor].opacity(0.6))
                    }
                }
                .frame(minHeight: 60)
            }
         
            HeatmapView(data: convertDictionaryToYearlyArray(modal.data), color: Constants.color[modal.paletteColor])
                .padding(.vertical, -4)
                
        }
        .padding(16)
        .background {
            Rectangle()
                .fill(Constants.color[modal.paletteColor])
                .opacity(0.1)
        }
        .cornerRadius(12)
        .onAppear(perform: {
            let today = getTodayDate()
            if let value = modal.data[today] {
                int = value
            }
            print(modal.data)
        })
    }
}

#Preview {
    OverAllListTrackerItem(modal: Modal(name: "Task Test", color: 5, image: 0, dailyTotal: 2, streak: 9, frequency: "", dailyData: [:]))
}


struct HeatmapView: View {
    @State var data: [Int]
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let color: Color
    var body: some View {
        VStack {
            HStack(spacing: 1.3) {
                ForEach(0..<data.count / 7) { row in
                    VStack(spacing: 2) {
                        ForEach(0..<7) { col in
                            let index = row * 7 + col
                            let count = self.data[index]
                            BoxView(count: count, color: color)
                                .onAppear {
                                    if count != 0 {
                                        print(count)
                                        print(data.count)
                                    }
                                }
                        }
                    }
                }
            }
        }
//        .padding()
    }
}

struct BoxView: View {
    let count: Int
    let color: Color
    var body: some View {
        Rectangle()
            .foregroundColor(heatmapColor(for: count))
            .frame(width: 5, height: 5)
            .cornerRadius(2)
    }
    
    private func heatmapColor(for count: Int) -> Color {
        switch count {
        case 0:
            return Color.gray.opacity(0.3)
        case 1...5:
            return color.opacity(0.5)
        case 6...10:
            return color.opacity(0.8)
        default:
            return color
        }
    }
}
