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
}

struct FoodEntry: Identifiable, Codable {
    let id: UUID
    var date: Date
    var ingredients: [Ingredient]
    
    var totalCalories: Double {
        ingredients.reduce(0) { $0 + $1.calories }
    }
}
