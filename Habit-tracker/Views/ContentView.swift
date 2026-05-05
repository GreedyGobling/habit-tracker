import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var habits: [Habit]

    @State private var vm: HabitViewModel
    @State private var habitname: String = ""
    

    var body: some View {
        NavigationStack {
            VStack {
                Text("hello")
                TextField("name of habita", text: $habitname)
                List {

                }
                Button("add habit"){
                    vm.addHabit(title: habitname, context: modelContext)
                    habitname = ""
                }
            }
            .padding()
        }
    }
}
