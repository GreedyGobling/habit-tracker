import Foundation
import Observation
import SwiftData

@Observable
class HabitViewModel {

    func addHabit(title: String, context: ModelContext) {
        let habit = Habit(title: title)
        context.insert(habit)
    }

    func deleteHabit(_ habit: Habit, context: ModelContext) {
        context.delete(habit)
    }

    func deleteAll(context: ModelContext) {
        let descriptor = FetchDescriptor<Habit>()
        if let habits = try? context.fetch(descriptor) {
            for habit in habits {
                context.delete(habit)
            }
        }
    }

    func markDone(_ habit: Habit, context: ModelContext) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let last = habit.lastCompletedDate, calendar.isDate(last, inSameDayAs: today) {
            return
        }

        let previousDate = habit.lastCompletedDate
        habit.isDone = true
        habit.completed += 1
        habit.lastCompletedDate = today

        if let last = previousDate,
           let yesterday = calendar.date(byAdding: .day, value: -1, to: today),
           calendar.isDate(last, inSameDayAs: yesterday) {
            habit.currentStreak += 1
        } else {
            habit.currentStreak = 1
        }

        if habit.currentStreak > habit.maxStreak {
            habit.maxStreak = habit.currentStreak
        }
        try? context.save()
    }
}
