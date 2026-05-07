import Foundation
import SwiftData

@Model
class Habit {
    var title: String
    var completed: Int = 0
    var lastCompletedDate: Date?

    var currentStreak: Int = 0
    var maxStreak: Int = 0

    var doneToday: Bool {
        guard let last = lastCompletedDate else { return false }
        return Calendar.current.isDateInToday(last)
    }

    init(title: String) {
        self.title = title
        self.currentStreak = 0
    }
}
