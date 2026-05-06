//
//  EditAddView.swift
//  Habit-tracker
//
//  Created by robin on 2026-05-02.
//

import SwiftData
// adding and editing a habit
import SwiftUI

// adding enum for ui stuff
enum EditorMode {
    case add
    case edit(Habit)
    case view
}

struct EditorView: View {
    //var mode: EditorMode
    var habit: Habit?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var vm = HabitViewModel()

    @State private var habitname: String = ""
    

    var body: some View {
        VStack {
            Label(habit == nil ? "New Habit" : "Edit Habit", systemImage: habit == nil ? "plus.circle.fill" : "square.and.pencil")
                .font(.headline)

            TextField("name of habit", text: $habitname)

            Button {
                if let habit {
                    habit.title = habitname
                } else {
                    vm.addHabit(title: habitname, context: modelContext)
                }
                dismiss()
            } label: {
                Label(habit == nil ? "Add" : "Save", systemImage: habit == nil ? "plus" : "square.and.arrow.down")
            }
            .disabled(habitname.isEmpty)

            // make seperate button func with if enum case TODO
            Button(role: .destructive) {
                if let habit {
                    vm.deleteHabit(habit, context: modelContext)
                    dismiss()
                }
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .disabled(habit == nil)
            .opacity(habit == nil ? 0 : 1)

            Button {
                dismiss()
            } label: {
                Label("Dismiss", systemImage: "xmark")
            }
        }
        .onAppear {
            habitname = habit?.title ?? ""
        }
    }

}
