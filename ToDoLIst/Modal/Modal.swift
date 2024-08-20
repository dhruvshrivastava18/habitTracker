//
//  Modal.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 22/07/24.
//

import Foundation
import SwiftData
import SwiftUI

//@Model
//class Modal: Identifiable {
//    
//    var id: String
//    var name: String
//    var color: Int
//    var image: Int
//    var dailyTotal: Int
//    var streak: Int
//    var frequency: String
//    var dailyData: [Date:Int]
//    
//    init(name: String, color: Int, image: Int, dailyTotal: Int, streak: Int, frequency: String, dailyData: [Date:Int]) {
//        self.id = UUID().uuidString
//        self.name = name
//        self.color = color
//        self.image = image
//        self.dailyTotal = dailyTotal
//        self.streak = streak
//        self.frequency = frequency
//        self.dailyData = dailyData
//    }
//    
//}


@Model
final class Modal: Identifiable {
    @Attribute(.unique) var id: String
    var name: String = ""
    var paletteColor: Int = 0
    var image: Int = 0
    var dailyTotal: Int = 0
    var streak: Int = 0
    var frequency: String = ""
    var data: [ Date : Int ] = [:]
    
    init(name: String, color: Int, image: Int, dailyTotal: Int, streak: Int, frequency: String, dailyData: [ Date : Int]) {
        self.id = UUID().uuidString
        self.name = name
        self.paletteColor = color
        self.image = image
        self.dailyTotal = dailyTotal
        self.streak = streak
        self.frequency = frequency
        self.data = dailyData
    }
    
}
