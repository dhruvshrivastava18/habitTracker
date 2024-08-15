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
        
        var result = Array(repeating: 0, count: 364)
        
        for i in 0..<363 {
            let date = calendar.date(byAdding: .day, value: -i, to: today)!
            if date >= oneYearAgo {
                if let value = dictionary.first(where: { calendar.isDate($0.key, inSameDayAs: date) })?.value {
                    result[363 - i] = value
                }
            }
        }
        print(result)
        return result
    } else {
        let today = calendar.startOfDay(for: Date())
        let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: today)!
        
        var result = Array(repeating: 0, count: 364)
        
        for i in 0..<363 {
            let date = calendar.date(byAdding: .day, value: -i, to: today)!
            if date >= oneYearAgo {
                if let value = dictionary.first(where: { calendar.isDate($0.key, inSameDayAs: date) })?.value {
                    result[363 - i] = value
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

func findLongestStreak(_ dict: [Date: Int], dailyTotal: Int) -> Int {
    
    let sortedDates = dict.keys.sorted()
    
    var longestSequence = 1
    var currentSequence = 1

    for i in 1..<sortedDates.count {
        let previousDate = sortedDates[i - 1]
        let currentDate = sortedDates[i]
        
        // Check if the current date is the next day of the previous date
        let difference = Calendar.current.dateComponents([.day], from: previousDate, to: currentDate).day ?? 0
        
        if (difference == 1) && (dict[previousDate] == dailyTotal) && (dict[currentDate] == dailyTotal) {
            currentSequence += 1
            longestSequence = max(longestSequence, currentSequence)
        } else {
            currentSequence = 1
        }
    }
    
    return longestSequence
}

func findTotalDaysCompleted(_ dict: [Date: Int], dailyTotal: Int) -> Int {
    
    let keys = dict.keys
    
    var totalCompleted = 0
    
    keys.forEach { key in
        if dict[key] == dailyTotal {
            totalCompleted = totalCompleted + 1
        }
    }
    
    return totalCompleted
}

func findCurrentStreak(_ dict: [Date: Int], dailyTotal: Int) -> Int {
    
    let dates = dict.keys.sorted()
    
    guard !dates.isEmpty else { return 0 }
        
        var currentSequence = 1
        
        for i in stride(from: dates.count - 1, through: 1, by: -1) {
            let previousDate = dates[i - 1]
            let currentDate = dates[i]
            
            // Check if the current date is the day before the previous date
            let difference = Calendar.current.dateComponents([.day], from: previousDate, to: currentDate).day ?? 0
            
            if (difference == 1) && (dict[previousDate] == dailyTotal) && (dict[currentDate] == dailyTotal) {
                currentSequence += 1
            } else {
                break // If a non-consecutive date is found, stop counting
            }
        }
        
        // If the sequence starts from the largest date, return its length
        return currentSequence > 0 ? currentSequence : 0
}
