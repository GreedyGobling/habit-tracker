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
                    HStack { // sort the habits??? done to not done + letter sorting???
                        Image(systemName: habit.doneToday ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(habit.doneToday ? .green : .secondary)
                        Text(habit.title)
                        Spacer()
                        // change that the number and flame closer?
                        Label("\(habit.actualCurrentStreak)", systemImage: "flame.fill")
                            .labelStyle(.titleAndIcon)
                            .foregroundStyle(.orange)
                        
                        // change toggle to button would look better i think
                        Toggle(
                            "",
                            isOn: Binding(
                                get: { habit.doneToday },
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
        }
        .padding()
        .sheet(isPresented: $showEditor) {
            EditorView(habit: selectedHabit)
        }
        .alert(
            "Ett fel intraffade",
            isPresented: Binding(
                get: { vm.errorMessage != nil },
                set: { if !$0 { vm.errorMessage = nil } }
            )
        ) {
            Button("OK", role: .cancel) { vm.errorMessage = nil }
        } message: {
            Text(vm.errorMessage ?? "")
        }
    }
}
