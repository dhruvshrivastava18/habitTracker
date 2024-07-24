//
//  Modal.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 22/07/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Modal: Identifiable {
    
    var id: String = UUID().uuidString
    var name: String
    var color: Int
    var image: Int
    var dailyTotal: Int
    var streak: Int
    var frequency: String
    var dailyData: [Date:Int]
    
    init(name: String, color: Int,image: Int, dailyTotal: Int, streak: Int,frequency: String, dailyData: [Date:Int]) {
        self.name = name
        self.color = color
        self.image = image
        self.dailyTotal = dailyTotal
        self.streak = streak
        self.frequency = frequency
        self.dailyData = dailyData
    }
    
}
