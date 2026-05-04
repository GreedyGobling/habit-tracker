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
        try? context.delete(model: Habit.self)
    }

    func markDone(_ habit: Habit, context: ModelContext) {
        habit.isDone = true
        habit.completed += 1
    }
}
