import Foundation
import SwiftUI

@MainActor
class AnalysisViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var ingredients: [Ingredient] = []
    @Published var isLoading = false

    private let session = URLSession.shared
    private let apiKey = "YOUR_OPENAI_API_KEY" // replace with test key

    func analyzeImage(_ uiImage: UIImage) async {
        self.image = uiImage
        guard let imageData = uiImage.jpegData(compressionQuality: 0.8) else { return }

        isLoading = true
        defer { isLoading = false }

        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let prompt = "Analyze the food in this image and return a JSON array of ingredients with their estimated calories."

        let payload: [String: Any] = [
            "model": "gpt-4-turbo",
            "messages": [
                ["role": "user", "content": [
                    ["type": "text", "text": prompt],
                    ["type": "image_url", "image_url": ["url": "data:image/jpeg;base64,\(imageData.base64EncodedString())"]]
                ]]
            ],
            "response_format": ["type": "json_object"]
        ]

        guard let body = try? JSONSerialization.data(withJSONObject: payload) else { return }
        request.httpBody = body

        do {
            let (data, _) = try await session.data(for: request)
            if let result = try? JSONDecoder().decode(OpenAIResponse.self, from: data) {
                self.ingredients = result.ingredients
            }
        } catch {
            print("OpenAI request failed: \(error)")
        }
    }

    func saveCurrentEntry() {
        var entries = StorageManager.shared.loadEntries()
        let entry = FoodEntry(id: UUID(), date: Date(), ingredients: ingredients)
        entries.append(entry)
        StorageManager.shared.saveEntries(entries)
    }
}

struct OpenAIResponse: Codable {
    let ingredients: [Ingredient]
}
