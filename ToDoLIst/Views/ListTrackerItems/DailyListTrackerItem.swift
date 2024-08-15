//
//  DailyListTrackerItem.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 17/07/24.
//

import SwiftUI
import ConfettiSwiftUI

struct DailyListTrackerItem: View {
    
    
    @Environment(\.modelContext) private var context
    
    @State var int = 0
    
    let modal: Modal
    
    var body: some View {
        NavigationLink {
            InfoView(modal: modal)
                .navigationBarBackButtonHidden()
        } label: {
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
                                .foregroundColor(Constants.AppWhite)
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
                            setupInitial()
//                            try? context.save()
                        } else {
                            int = 0
                            let today = getTodayDate()
                            modal.data.updateValue(int, forKey: today)
                            setupInitial()
//                            try? context.save()
                        }
                    } label: {
                        if int == modal.dailyTotal {
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
            .padding(16)
            .background {
                Rectangle()
                    .fill(Constants.color[modal.paletteColor])
                    .opacity(0.1)
            }
            .cornerRadius(12)
        }
        .onAppear(perform: {
            setupInitial()
        })
    }
    
    private func updateItem(_ item: Modal) {
        item.name = "Updated Data"
        try? context.save()
    }
    
    func setupInitial() {
        let today = getTodayDate()
        if let value = modal.data[today] {
            int = value
        }
        let dict = modal.data.sorted { $0.key < $1.key }
        let sortedDict = Dictionary(uniqueKeysWithValues: dict)
        
        for (key, value) in dict {
            print("Date \(key.formatted()) value \(value)")
        }
        print(modal.data.keys.sorted())
        modal.data = sortedDict
        let streak = findCurrentStreak(modal.data, dailyTotal: modal.dailyTotal)
        modal.streak = streak
        print(streak)

        try? context.save()
    }
    
}



//#Preview {
//    DailyListTrackerItem(image: Image(.dumbell), text: "Leetcode", total: 2, color: Color(hex: "9677b3"), streak: 3)
//}
