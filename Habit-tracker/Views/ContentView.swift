import SwiftUI

struct ContentView: View {
    @State private var habitname: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("hello")
                TextField("name of habita", text: $habitname)
                List {
                }
            }
            .padding()
        }
    }
}
