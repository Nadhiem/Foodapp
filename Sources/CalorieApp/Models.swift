import Foundation

struct Ingredient: Identifiable, Codable {
    let id: UUID
    var name: String
    var calories: Double
    var quantity: String?

    init(name: String, calories: Double, quantity: String? = nil) {
        self.id = UUID()
        self.name = name
        self.calories = calories
        self.quantity = quantity
    }

    private enum CodingKeys: String, CodingKey {
        case id, name, calories, quantity
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        self.name = try container.decode(String.self, forKey: .name)
        self.calories = try container.decode(Double.self, forKey: .calories)
        self.quantity = try container.decodeIfPresent(String.self, forKey: .quantity)
    }
}

struct FoodEntry: Identifiable, Codable {
    let id: UUID
    var date: Date
    var ingredients: [Ingredient]
    
    var totalCalories: Double {
        ingredients.reduce(0) { $0 + $1.calories }
    }
}
