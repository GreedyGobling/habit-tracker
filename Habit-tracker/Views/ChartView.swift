import Charts
import SwiftData
import SwiftUI

struct ChartView: View {
    @Query(sort: \Habit.title) private var habits: [Habit]
    private let calendar = Calendar.current

    private var weekStats: [WeekStat] {
        let startOfToday = calendar.startOfDay(for: Date())
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: startOfToday) else {
            return []
        }

        return stride(from: 0, to: 7, by: 1).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: weekInterval.start) else {
                return nil
            }

            let count = habits.reduce(into: 0) { total, habit in
                total += habit.completionDates.filter { completionDate in
                    calendar.isDate(completionDate, inSameDayAs: date)
                }.count
            }

            return WeekStat(date: date, count: count)
        }
    }

    var body: some View {
        Group {
            if habits.isEmpty {
                ContentUnavailableView(
                    "No habits yet",
                    systemImage: "chart.bar",
                    description: Text("Add a habit to see your stats.")
                )
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Total completions")
                                .font(.headline)

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
                            .frame(height: 240)
                            .chartYAxisLabel("Times completed")
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("This week")
                                .font(.headline)

                            if habits.contains(where: { !$0.completionDates.isEmpty }) {
                                Chart(weekStats) { stat in
                                    BarMark(
                                        x: .value("Day", stat.date, unit: .day),
                                        y: .value("Completed", stat.count)
                                    )
                                    .foregroundStyle(.green.gradient)
                                    .annotation(position: .top) {
                                        if stat.count > 0 {
                                            Text("\(stat.count)")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                                .frame(height: 240)
                                .chartXAxis {
                                    AxisMarks(values: .stride(by: .day)) {
                                        AxisGridLine()
                                        AxisTick()
                                        AxisValueLabel(format: .dateTime.weekday(.abbreviated))
                                    }
                                }
                                .chartYAxisLabel("Completions")
                            } else {
                                ContentUnavailableView(
                                    "No weekly data yet",
                                    systemImage: "calendar",
                                    description: Text("Complete habits this week to fill the weekly chart.")
                                )
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Stats")
    }
}

private struct WeekStat: Identifiable {
    let date: Date
    let count: Int

    var id: Date { date }
}
