import Foundation

public enum Cuisine: String, CaseIterable, Identifiable, Codable {
    case italian
    case mexican
    case indian
    case chinese
    case american
    case french
    case japanese
    case mediterranean
    case thai
    case other

    public var id: String { rawValue }

    public var displayName: String { rawValue.capitalized }
}

public enum Difficulty: String, CaseIterable, Identifiable, Codable {
    case easy
    case medium
    case hard

    public var id: String { rawValue }

    public var displayName: String { rawValue.capitalized }
}

public struct Recipe: Identifiable, Hashable, Codable {
    public let id: UUID
    public var title: String
    public var cuisine: Cuisine
    public var difficulty: Difficulty
    public var cookTimeMinutes: Int
    public var ingredients: [String]
    public var isVegan: Bool
    public var isVegetarian: Bool
    public var isGlutenFree: Bool
    public var ratingOutOfFive: Double

    public init(
        id: UUID = UUID(),
        title: String,
        cuisine: Cuisine,
        difficulty: Difficulty,
        cookTimeMinutes: Int,
        ingredients: [String],
        isVegan: Bool = false,
        isVegetarian: Bool = false,
        isGlutenFree: Bool = false,
        ratingOutOfFive: Double = 0
    ) {
        self.id = id
        self.title = title
        self.cuisine = cuisine
        self.difficulty = difficulty
        self.cookTimeMinutes = cookTimeMinutes
        self.ingredients = ingredients
        self.isVegan = isVegan
        self.isVegetarian = isVegetarian
        self.isGlutenFree = isGlutenFree
        self.ratingOutOfFive = ratingOutOfFive
    }
}

public extension Recipe {
    static let sample: [Recipe] = [
        Recipe(
            title: "Margherita Pizza",
            cuisine: .italian,
            difficulty: .medium,
            cookTimeMinutes: 30,
            ingredients: ["flour", "tomato", "mozzarella", "basil", "olive oil"],
            isVegan: false,
            isVegetarian: true,
            isGlutenFree: false,
            ratingOutOfFive: 4.5
        ),
        Recipe(
            title: "Chicken Tacos",
            cuisine: .mexican,
            difficulty: .easy,
            cookTimeMinutes: 20,
            ingredients: ["chicken", "tortilla", "onion", "cilantro", "lime"],
            ratingOutOfFive: 4.2
        ),
        Recipe(
            title: "Chana Masala",
            cuisine: .indian,
            difficulty: .medium,
            cookTimeMinutes: 40,
            ingredients: ["chickpeas", "tomato", "onion", "garlic", "garam masala"],
            isVegan: true,
            isVegetarian: true,
            ratingOutOfFive: 4.7
        ),
        Recipe(
            title: "Sushi Rolls",
            cuisine: .japanese,
            difficulty: .hard,
            cookTimeMinutes: 60,
            ingredients: ["rice", "nori", "salmon", "avocado", "cucumber"],
            ratingOutOfFive: 4.8
        ),
        Recipe(
            title: "Pad Thai",
            cuisine: .thai,
            difficulty: .medium,
            cookTimeMinutes: 30,
            ingredients: ["rice noodles", "tofu", "egg", "peanuts", "tamarind"],
            isVegetarian: true,
            ratingOutOfFive: 4.6
        ),
        Recipe(
            title: "Greek Salad",
            cuisine: .mediterranean,
            difficulty: .easy,
            cookTimeMinutes: 10,
            ingredients: ["cucumber", "tomato", "feta", "olive", "olive oil"],
            isVegetarian: true,
            isGlutenFree: true,
            ratingOutOfFive: 4.3
        ),
        Recipe(
            title: "Beef Bourguignon",
            cuisine: .french,
            difficulty: .hard,
            cookTimeMinutes: 180,
            ingredients: ["beef", "red wine", "carrot", "onion", "mushroom"],
            ratingOutOfFive: 4.9
        ),
        Recipe(
            title: "General Tso's Cauliflower",
            cuisine: .chinese,
            difficulty: .medium,
            cookTimeMinutes: 35,
            ingredients: ["cauliflower", "soy sauce", "garlic", "ginger", "rice"],
            isVegan: true,
            isVegetarian: true,
            ratingOutOfFive: 4.4
        ),
        Recipe(
            title: "Gluten-Free Pancakes",
            cuisine: .american,
            difficulty: .easy,
            cookTimeMinutes: 15,
            ingredients: ["gluten-free flour", "milk", "egg", "baking powder", "syrup"],
            isGlutenFree: true,
            ratingOutOfFive: 4.1
        ),
        Recipe(
            title: "Quinoa Buddha Bowl",
            cuisine: .other,
            difficulty: .easy,
            cookTimeMinutes: 25,
            ingredients: ["quinoa", "chickpeas", "spinach", "avocado", "tahini"],
            isVegan: true,
            isVegetarian: true,
            isGlutenFree: true,
            ratingOutOfFive: 4.5
        )
    ]
}