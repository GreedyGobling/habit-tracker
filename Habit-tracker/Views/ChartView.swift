import Charts
import SwiftData
import SwiftUI

struct ChartView: View {
    @Query(sort: \Habit.title) private var habits: [Habit]

    var body: some View {
        Group {
            if habits.isEmpty {
                ContentUnavailableView(
                    "No habits yet",
                    systemImage: "chart.bar",
                    description: Text("Add a habit to see your stats.")
                )
            } else {
                Chart(habits) { habit in
                    BarMark(
                        x: .value("Habit", habit.title),
                        y: .value("Completed", habit.completed)
                    )
                    .foregroundStyle(by: .value("Habit", habit.title))
                    .annotation(position: .top) {
                        Text("\(habit.completed)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .chartYAxisLabel("Times completed")
                .padding()
            }
        }
        .navigationTitle("Stats")
    }
}
