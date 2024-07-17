//
//  Constants.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 16/07/24.
//

import Foundation
import SwiftUI


struct Constants {
    
    // Colors
    static let AppGreen: Color = Color(light: Color(hex: "7ddb7b"), dark: Color(hex: "7ad578"))
    static let AppWhite: Color = Color(light: Color(hex: "000001"), dark: Color(hex: "ffffff"))
    static let AppBlack: Color = Color(light: Color(hex: "ffffff"), dark: Color(hex: "000001"))
    static let pickerGreen: Color = Color(light: Color(hex: "006e1d"), dark: Color(hex: "7ddb7b"))
    static let settingsButtonColor = Color(light: Color(hex: "b6f2af"), dark: Color(hex: "426741")) 
    static let selectedTabColor = Color(light: Color(hex: "b6f2af"), dark: Color(hex: "005313")) 
    static let grayBackground = Color(light: Color(hex: "f2f7f4"), dark: Color(hex: "232323"))
    
    // General Constants
    static let color: [Color] = [
        Color(light: Color(hex: "4c9a60"), dark: Color(hex: "025315")),
        Color(light: Color(hex: "ffa74b"), dark: Color(hex: "ba5f06")),
        Color(light: Color(hex: "9965fb"), dark: Color(hex: "511eb3")),
        Color(light: Color(hex: "797fe9"), dark: Color(hex: "3137a6")),
        Color(light: Color(hex: "4c8dcc"), dark: Color(hex: "004886")),
        Color(light: Color(hex: "9263c4"), dark: Color(hex: "4d1b7c")),
        Color(light: Color(hex: "4c95a7"), dark: Color(hex: "054d62")),
        Color(light: Color(hex: "8788ff"), dark: Color(hex: "4142b9")),
        Color(light: Color(hex: "728cc2"), dark: Color(hex: "2b467d")),
        Color(light: Color(hex: "bd7488"), dark: Color(hex: "802a3f")),
        Color(light: Color(hex: "bd7488"), dark: Color(hex: "9677b3")),
        Color(light: Color(hex: "ce6163"), dark: Color(hex: "7b2018")),
        Color(light: Color(hex: "fea271"), dark: Color(hex: "b85a2e")),
        Color(light: Color(hex: "ffb77b"), dark: Color(hex: "b77137")),
        Color(light: Color(hex: "ffb77b"), dark: Color(hex: "5d21b7")),
        Color(light: Color(hex: "ff4d4c"), dark: Color(hex: "ae0c06"))
    ]
    static let frequency = ["Daily", "Weekly", "Monthly"]
    static let tabs = ["Today", "Weekly", "Overall"]
    static let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    static let theme = ["System", "Light", "Dark"]
    static let startDays = ["Saturday", "Sunday", "Monday"]
 }
