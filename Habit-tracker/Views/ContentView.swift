import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var habits: [Habit]
    @State private var vm = HabitViewModel()

    @State private var showEditor = false
    @State private var selectedHabit: Habit? = nil

    var body: some View {
        NavigationStack {
            VStack {
                List(habits) { habit in
                    HStack {
                        Image(systemName: habit.isDone ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(habit.isDone ? .green : .secondary)
                        Text(habit.title)
                        Spacer()
                        Label("\(habit.currentStreak)", systemImage: "flame.fill")
                            .labelStyle(.titleAndIcon)
                            .foregroundStyle(.orange)
                        Toggle(
                            "",
                            isOn: Binding(
                                get: { habit.isDone },
                                set: { _ in vm.markDone(habit, context: modelContext) }
                            ))
                    }
                    .onTapGesture {
                        selectedHabit = habit
                        showEditor = true
                    }
                }
            }
            .navigationTitle("Habit Tracker")

            Button {
                selectedHabit = nil
                showEditor = true
            } label: {
                Label("Add new habit", systemImage: "plus.circle.fill")
            }

            Button(role: .destructive) {
                vm.deleteAll(context: modelContext)
            } label: {
                Label("Delete all", systemImage: "trash")
            }
        }
        .padding()
        .sheet(isPresented: $showEditor) {
            EditorView(habit: selectedHabit)
        }
    }
}
