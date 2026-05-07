import Foundation
import Observation
import SwiftData

@Observable
class HabitViewModel {

    var errorMessage: String?

    func addHabit(title: String, context: ModelContext) {
        let habit = Habit(title: title)
        context.insert(habit)
        do {
            try context.save()
        } catch {
            errorMessage = "Kunde inte spara vana: \(error.localizedDescription)"
        }
    }

    func deleteHabit(_ habit: Habit, context: ModelContext) {
        context.delete(habit)
        do {
            try context.save()
        } catch {
            errorMessage = "Kunde inte radera vana: \(error.localizedDescription)"
        }
    }

    func deleteAll(context: ModelContext) {
        let descriptor = FetchDescriptor<Habit>()
        do {
            let habits = try context.fetch(descriptor)
            for habit in habits {
                context.delete(habit)
            }
            try context.save()
        } catch {
            errorMessage = "Kunde inte radera alla vanor: \(error.localizedDescription)"
        }
    }

    func markDone(_ habit: Habit, context: ModelContext) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let last = habit.lastCompletedDate, calendar.isDate(last, inSameDayAs: today) {
            return
        }

        let previousDate = habit.lastCompletedDate
        let streakBeforeToday = habit.actualCurrentStreak
        habit.completed += 1
        habit.lastCompletedDate = today

        if let last = previousDate,
           let yesterday = calendar.date(byAdding: .day, value: -1, to: today),
           calendar.isDate(last, inSameDayAs: yesterday) {
            habit.currentStreak = streakBeforeToday + 1
        } else {
            habit.currentStreak = 1
        }

        if habit.currentStreak > habit.maxStreak {
            habit.maxStreak = habit.currentStreak
        }

        do {
            try context.save()
        } catch {
            errorMessage = "Kunde inte spara markering: \(error.localizedDescription)"
        }
    }
}
