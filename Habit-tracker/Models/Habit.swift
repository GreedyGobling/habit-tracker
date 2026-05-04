import SwiftData

@Model
class Habit {
    var title: String
    var isDone: Bool = false
    var completed: Int = 0

    init(title: String) {
        self.title = title
    }
}
