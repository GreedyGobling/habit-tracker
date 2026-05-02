import SwiftData

@Model
class Habit {
    var title: String
    var isDone: Bool = false
    
    init(title: String, isDone: Bool = false) {
        self.title = title
        self.isDone = isDone
    }
    
    func deleteAll() {
        // delete all data in habit
    }
    
}
