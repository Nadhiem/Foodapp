import SwiftUI

struct HistoryView: View {
    @State private var entries: [FoodEntry] = StorageManager.shared.loadEntries()

    var body: some View {
        List(entries) { entry in
            VStack(alignment: .leading) {
                Text(entry.date, style: .date)
                    .font(.headline)
                Text("Total Calories: \(entry.totalCalories, format: .number)")
            }
        }
        .navigationTitle("History")
        .onAppear {
            entries = StorageManager.shared.loadEntries()
        }
    }
}
