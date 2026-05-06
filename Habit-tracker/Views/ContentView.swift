import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var habits: [Habit]

    @State private var vm = HabitViewModel()
    @State private var habitname: String = ""

    @State private var showEditor = false
    @State private var selectedHabit: Habit? = nil

    var body: some View {
        NavigationStack {
            VStack {
                Text("hello")
                TextField("name of habita", text: $habitname)
                List(habits) { habit in
                    HStack {
                        Text(habit.title)
                        Text("current streak: \(habit.currentStreak)")
                        Toggle(
                            "",
                            isOn: Binding(
                                get: { habit.isDone },
                                set: { _ in vm.markDone(habit, context: modelContext) }
                            ))
                    }
                    .onTapGesture { selectedHabit = habit; showEditor = true}
                }
                
            }
            Button("add habit") {
                vm.addHabit(title: habitname, context: modelContext)
                habitname = ""
            }
            Button("delete all") {
                vm.deleteAll(context: modelContext)
            }
        }
        .padding()
        .sheet(isPresented: $showEditor) {
            EditorView(habit: selectedHabit)
        }
    }
}
