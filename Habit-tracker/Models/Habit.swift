import Foundation
import SwiftData

@Model
class Habit {
    var title: String
    var completed: Int = 0
    var lastCompletedDate: Date?

    var currentStreak: Int = 0
    var maxStreak: Int = 0
    var completionDates: [Date] = []

    var doneToday: Bool {
        guard let last = lastCompletedDate else { return false }
        return Calendar.current.isDateInToday(last)
    }

    var actualCurrentStreak: Int {
        guard let last = lastCompletedDate else { return 0 }

        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if calendar.isDate(last, inSameDayAs: today) {
            return currentStreak
        }

        if let yesterday = calendar.date(byAdding: .day, value: -1, to: today),
           calendar.isDate(last, inSameDayAs: yesterday) {
            return currentStreak
        }

        return 0
    }

    init(title: String) {
        self.title = title
        self.currentStreak = 0
    }
}
