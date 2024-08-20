//
//  DateValue.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 18/08/24.
//

import SwiftUI

struct DateValue: Identifiable {
    var id: String = UUID().uuidString
    var day: Int
    var date: Date
}
