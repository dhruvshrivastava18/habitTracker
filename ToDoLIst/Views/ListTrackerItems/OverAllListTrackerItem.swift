//
//  OverAllListTrackerItem.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 20/07/24.
//

import SwiftUI

struct OverAllListTrackerItem: View {
    
    @State var int = 2
    
    let modal: Modal
    
    var data: [Double] = [0.3, 0.4, 0.4, 0.4, 0.1, 0.5, 0.0, 0.1, 0.0, 0.2, 0.2, 0.2, 0.0, 0.2, 0.2, 0.5, 0.4, 0.2, 0.4, 0.5, 0.2, 0.2, 0.4, 0.3, 0.3, 0.2, 0.4, 0.0, 0.0, 0.5, 0.4, 0.3, 0.5, 0.3, 0.0, 0.0, 0.1, 0.0, 0.2, 0.3, 0.0, 0.0, 0.0, 0.5, 0.3, 0.3, 0.0, 0.3, 0.0, 0.5, 0.3, 0.3, 0.4, 0.5, 0.5, 0.3, 0.4, 0.1, 0.4, 0.2, 0.5, 0.1, 0.4, 0.2, 0.5, 0.4, 0.3, 0.5, 0.0, 0.4, 0.3, 0.2, 0.1, 0.5, 0.2, 0.0, 0.2, 0.5, 0.5, 0.3, 0.4, 0.0, 0.3, 0.3, 0.1, 0.2, 0.5, 0.2, 0.1, 0.4, 0.4, 0.0, 0.5, 0.3, 0.3, 0.5, 0.0, 0.2, 0.3, 0.4, 0.4, 0.4, 0.1, 0.5, 0.0, 0.1, 0.0, 0.2, 0.2, 0.2, 0.0, 0.2, 0.2, 0.5, 0.4, 0.2, 0.4, 0.5, 0.2, 0.2, 0.4, 0.3, 0.3, 0.2, 0.4, 0.0, 0.0, 0.5, 0.4, 0.3, 0.5, 0.3, 0.0, 0.0, 0.1, 0.0, 0.2, 0.3, 0.0, 0.0, 0.0, 0.5, 0.3, 0.3, 0.0, 0.3, 0.0, 0.5, 0.3, 0.3, 0.4, 0.5, 0.5, 0.3, 0.4, 0.1, 0.4, 0.2, 0.5, 0.1, 0.4, 0.2, 0.5, 0.4, 0.3, 0.5, 0.0, 0.4, 0.3, 0.2, 0.1, 0.5, 0.2, 0.0, 0.2, 0.5, 0.5, 0.3, 0.4, 0.0, 0.3, 0.3, 0.1, 0.2, 0.5, 0.2, 0.1, 0.4, 0.4, 0.0, 0.5, 0.3, 0.3, 0.5, 0.0, 0.2]
   
    
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
                        } else {
                            int = 0
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
            }
         
            ChartsCard()
                
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

//#Preview {
//    OverAllListTrackerItem(image: Image(.dumbell), text: "Leetcode", total: 2, color: Color(hex: "9677b3"), streak: 3)
//}


struct HeatmapView: View {
    let data: [Int]
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var body: some View {
        VStack {
            HStack(spacing: 2) {
                ForEach(0..<data.count / 7) { row in
                    VStack(spacing: 2) {
                        ForEach(0..<7) { col in
                            let index = row * 7 + col
                            let count = self.data[index]
                            BoxView(count: count)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct BoxView: View {
    let count: Int
    
    var body: some View {
        Rectangle()
            .foregroundColor(heatmapColor(for: count))
            .frame(width: 5, height: 5)
            .cornerRadius(4)
    }
    
    private func heatmapColor(for count: Int) -> Color {
        switch count {
        case 0:
            return Color.gray.opacity(0.3)
        case 1...5:
            return Color.blue.opacity(0.5)
        case 6...10:
            return Color.blue.opacity(0.8)
        default:
            return Color.blue
        }
    }
}

struct ChartsCard: View {
    @State private var data: [Int] = (1...365).map { _ in Int.random(in: 0...15) }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text("Habit's Heat Map")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.8))
                .padding(.horizontal)
            HeatmapView(data: data)
        }
        .frame(maxWidth: 400, alignment: .leading)
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
        .padding(1)
        .shadow(color: Color.gray.opacity(0.4), radius: 8, x: 0, y: 2)
        .onAppear {
            self.startRefreshing()
        }
    }
    
    private func startRefreshing() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            DispatchQueue.main.async {
                self.data = (1...365).map { _ in Int.random(in: 0...15) }
            }
        }
    }
}
