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
        habit.isDone = true
        habit.completed += 1
    }
}
