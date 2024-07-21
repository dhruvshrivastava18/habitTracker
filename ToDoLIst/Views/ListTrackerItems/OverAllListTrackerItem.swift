//
//  OverAllListTrackerItem.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 20/07/24.
//

import SwiftUI
import ContributionChart

struct OverAllListTrackerItem: View {
    @State var int = 2
    
    var image: Image
    var text: String
    var total: Int
    var color: Color
    var streak: Int
    var data: [Double] = [0.3, 0.4, 0.4, 0.4, 0.1, 0.5, 0.0, 0.1, 0.0, 0.2, 0.2, 0.2, 0.0, 0.2, 0.2, 0.5, 0.4, 0.2, 0.4, 0.5, 0.2, 0.2, 0.4, 0.3, 0.3, 0.2, 0.4, 0.0, 0.0, 0.5, 0.4, 0.3, 0.5, 0.3, 0.0, 0.0, 0.1, 0.0, 0.2, 0.3, 0.0, 0.0, 0.0, 0.5, 0.3, 0.3, 0.0, 0.3, 0.0, 0.5, 0.3, 0.3, 0.4, 0.5, 0.5, 0.3, 0.4, 0.1, 0.4, 0.2, 0.5, 0.1, 0.4, 0.2, 0.5, 0.4, 0.3, 0.5, 0.0, 0.4, 0.3, 0.2, 0.1, 0.5, 0.2, 0.0, 0.2, 0.5, 0.5, 0.3, 0.4, 0.0, 0.3, 0.3, 0.1, 0.2, 0.5, 0.2, 0.1, 0.4, 0.4, 0.0, 0.5, 0.3, 0.3, 0.5, 0.0, 0.2, 0.3, 0.4, 0.4, 0.4, 0.1, 0.5, 0.0, 0.1, 0.0, 0.2, 0.2, 0.2, 0.0, 0.2, 0.2, 0.5, 0.4, 0.2, 0.4, 0.5, 0.2, 0.2, 0.4, 0.3, 0.3, 0.2, 0.4, 0.0, 0.0, 0.5, 0.4, 0.3, 0.5, 0.3, 0.0, 0.0, 0.1, 0.0, 0.2, 0.3, 0.0, 0.0, 0.0, 0.5, 0.3, 0.3, 0.0, 0.3, 0.0, 0.5, 0.3, 0.3, 0.4, 0.5, 0.5, 0.3, 0.4, 0.1, 0.4, 0.2, 0.5, 0.1, 0.4, 0.2, 0.5, 0.4, 0.3, 0.5, 0.0, 0.4, 0.3, 0.2, 0.1, 0.5, 0.2, 0.0, 0.2, 0.5, 0.5, 0.3, 0.4, 0.0, 0.3, 0.3, 0.1, 0.2, 0.5, 0.2, 0.1, 0.4, 0.4, 0.0, 0.5, 0.3, 0.3, 0.5, 0.0, 0.2]
    let rows = 7
    let columns = 28
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(color.opacity(0.6))
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
                                .frame(width: 25, height: 25)
                                .foregroundColor(color)
                        } else {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 25, height: 25)
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
         
                    ContributionChartView(data: data, rows: rows, columns: columns, targetValue: 0.5)
                                        .frame(height: 200)
                
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
    OverAllListTrackerItem(image: Image(.dumbell), text: "Leetcode", total: 2, color: Color(hex: "9677b3"), streak: 3)
}
