//
//  Habit_trackerApp.swift
//  Habit-tracker
//
//  Created by robin on 2026-04-27.
//

import SwiftUI
import SwiftData

@main
struct Habit_trackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Habit.self)
    }
}
