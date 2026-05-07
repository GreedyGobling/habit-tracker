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
            TabView {
                ContentView()
                    .tabItem { Label("Habits", systemImage: "checklist") }
                NavigationStack { ChartView() }
                    .tabItem { Label("Stats", systemImage: "chart.bar.fill") }
            }
        }
        .modelContainer(for: Habit.self)
    }
}
