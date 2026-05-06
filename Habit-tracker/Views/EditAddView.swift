//
//  EditAddView.swift
//  Habit-tracker
//
//  Created by robin on 2026-05-02.
//

import SwiftData
// adding and editing a habit
import SwiftUI

struct EditorView: View {
    var habit: Habit?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var vm = HabitViewModel()

    @State private var habitname: String = ""

    var body: some View {
        VStack {
            TextField("name of habit", text: $habitname)

            Button(habit == nil ? "Add" : "Save") {
                if let habit {
                    habit.title = habitname
                } else {
                    vm.addHabit(title: habitname, context: modelContext)
                }
                dismiss()
            }
            .disabled(habitname.isEmpty)
            
            Button("Delete", role: .destructive) {
                if let habit {
                    vm.deleteHabit(habit, context: modelContext)
                    dismiss()
                }
            }
            .disabled(habit == nil)
            .opacity(habit == nil ? 0 : 1)
            
            Button("Dismiss") {
                dismiss()
            }
        }
        .onAppear {
            habitname = habit?.title ?? ""
        }
    }
}
