//
//  WeeklyListTrackerItem.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 19/07/24.
//

import SwiftUI

struct WeeklyListTrackerItem: View {
    
    @State var int = 0
    
//    var image: Image
//    var text: String
//    var total: Int
//    var color: Color
//    var streak: Int
//    var frequency: String
    var modal: Modal
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.purple)
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
                ForEach(Constants.days, id: \.self) { day in
                    WeeklyListItem(int: int, day: day, total: modal.dailyTotal, color: Constants.color[modal.paletteColor])
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
    }
}

struct WeeklyListItem: View {
    
    @State var int: Int
    
    var day: String
    var total: Int
    var color: Color
    
    var body: some View {
        VStack {
            Text(day)
                .font(.caption)
            Button {
                if int < total {
                    int = int + 1
                } else {
                    int = 0
                }
            } label: {
                if int == total {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(color)
                } else {
                    ZStack {
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(color)
                        Text("\(int)/\(total)")
                            .font(.system(size: 8, weight: .light))
                            .foregroundStyle(Constants.AppWhite)
                    }
                }
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(color.opacity(0.2))
        .cornerRadius(20)
    }
}

//#Preview {
//    WeeklyListTrackerItem(image: Image(.dumbell), text: "Leetcode", total: 2, color: Color(hex: "9677b3"), streak: 3, frequency: "Everyday")
//}
