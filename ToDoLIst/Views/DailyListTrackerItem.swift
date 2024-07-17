//
//  DailyListTrackerItem.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 17/07/24.
//

import SwiftUI

struct DailyListTrackerItem: View {
    @State var int = 2
    
    var image: Image
    var text: String
    var total: Int
    var color: Color
    var streak: Int
    
    var body: some View {
        HStack {
            HStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.purple)
                        .frame(width: 40, height: 40)
                        .cornerRadius(12)
                    image
                        .resizable()
                        .frame(width: 20, height:  20)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(text)
                        .foregroundColor(Constants.AppWhite)
                    HStack(spacing: 0) {
                        Text("🔥")
                            .font(.caption2)
                        Text("\(streak) Days")
                            .font(.caption2)
                    }
                }
            }
            Spacer()
            VStack {
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
                            .frame(width: 20, height: 20)
                            .foregroundColor(.green)
                            .background(.white)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(color.opacity(0.6))
                    }
                }
                if int != total {
                    Text("\(int)/\(total)")
                        .font(.caption)
                        .foregroundColor(color.opacity(0.6))
                }
            }
        }
        .padding(16)
        .background {
            Rectangle()
                .fill(color)
                .opacity(0.1)
        }
        .cornerRadius(12)
    }
}

#Preview {
    DailyListTrackerItem(image: Image(.dumbell), text: "Leetcode", total: 2, color: Color(hex: "9677b3"), streak: 3)
}
