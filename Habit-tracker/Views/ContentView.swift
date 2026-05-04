import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var habitname: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("hello")
                TextField("name of habita", text: $habitname)
                List {

                }
                Button("button") {

                }
            }
            .padding()
        }
    }
}
