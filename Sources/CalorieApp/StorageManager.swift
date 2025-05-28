import Foundation

@MainActor
final class StorageManager {
    static let shared = StorageManager()
    private let fileURL: URL

    private init() {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        fileURL = documents.appendingPathComponent("food_history.json")
    }

    func loadEntries() -> [FoodEntry] {
        guard let data = try? Data(contentsOf: fileURL) else { return [] }
        let entries = (try? JSONDecoder().decode([FoodEntry].self, from: data)) ?? []
        return entries
    }

    func saveEntries(_ entries: [FoodEntry]) {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        try? data.write(to: fileURL)
    }
}
