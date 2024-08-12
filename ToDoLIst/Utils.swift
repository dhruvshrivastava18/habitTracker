//
//  Utils.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 10/08/24.
//

import Foundation

func convertDictionaryToYearlyArray(_ dictionary: [Date: Int]) -> [Int] {
    let calendar = Calendar.current
    if let today = dictionary.keys.max() {
        let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: today)!
        
        var result = Array(repeating: 0, count: 365)
        
        for i in 0..<365 {
            let date = calendar.date(byAdding: .day, value: -i, to: today)!
            if date >= oneYearAgo {
                if let value = dictionary.first(where: { calendar.isDate($0.key, inSameDayAs: date) })?.value {
                    result[364 - i] = value
                }
            }
        }
        
        return result
    } else {
        let today = calendar.startOfDay(for: Date())
        let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: today)!
        
        var result = Array(repeating: 0, count: 365)
        
        for i in 0..<365 {
            let date = calendar.date(byAdding: .day, value: -i, to: today)!
            if date >= oneYearAgo {
                if let value = dictionary.first(where: { calendar.isDate($0.key, inSameDayAs: date) })?.value {
                    result[364 - i] = value
                }
            }
        }
        
        return result
    }
}

func getTodayDate() -> Date {
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    return today
}

enum WeekStartDay {
    case sunday, saturday, monday
}

func getCurrentWeekDates(startingFrom startDay: WeekStartDay = .sunday) -> [Date] {
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    
    // Determine the weekday value for the start of the week
    let startOfWeekDay: Int
    switch startDay {
    case .sunday: startOfWeekDay = 1
    case .saturday: startOfWeekDay = 7
    case .monday: startOfWeekDay = 2
    }
    
    // Calculate the start of the week
    let startOfWeek: Date = {
        let weekday = calendar.component(.weekday, from: today)
        let daysToSubtract = (weekday - startOfWeekDay + 7) % 7
        return calendar.date(byAdding: .day, value: -daysToSubtract, to: today)!
    }()
    
    // Generate dates for the week
    return (0..<7).map { day in
        calendar.date(byAdding: .day, value: day, to: startOfWeek)!
    }
}

func getDatesBasedOnStartStartDay(_ startDay: String) -> [Date] {
    if startDay == "Mon" {
        return getCurrentWeekDates(startingFrom: .monday)
    } else if startDay == "Sun" {
        return getCurrentWeekDates(startingFrom: .sunday)
    } else {
        return getCurrentWeekDates(startingFrom: .saturday)
    }
}
