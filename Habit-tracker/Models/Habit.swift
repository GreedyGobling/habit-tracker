//
//  Habit.swift
//  Habit-tracker
//
//  Created by robin on 2026-04-29.
//
import SwiftData

@Model
class Habit {
    var title: String
    var isDone: Bool = false
    
    init(title: String, isDone: Bool) {
        self.title = title
        self.isDone = isDone
    }
    
}
