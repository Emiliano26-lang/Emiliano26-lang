import Foundation

// MARK: - Recipe Model
struct Recipe: Identifiable, Codable {
    let id = UUID()
    let name: String
    let cuisine: Cuisine
    let cookingTime: Int // in minutes
    let difficulty: Difficulty
    let dietaryRestrictions: [DietaryRestriction]
    let ingredients: [String]
    let rating: Double
    let servings: Int
    let description: String
    let imageURL: String?
}

// MARK: - Filter Enums
enum Cuisine: String, CaseIterable, Codable {
    case italian = "Italian"
    case chinese = "Chinese"
    case mexican = "Mexican"
    case indian = "Indian"
    case american = "American"
    case french = "French"
    case japanese = "Japanese"
    case thai = "Thai"
    case mediterranean = "Mediterranean"
    case korean = "Korean"
}

enum Difficulty: String, CaseIterable, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

enum DietaryRestriction: String, CaseIterable, Codable {
    case vegetarian = "Vegetarian"
    case vegan = "Vegan"
    case glutenFree = "Gluten-Free"
    case dairyFree = "Dairy-Free"
    case keto = "Keto"
    case paleo = "Paleo"
    case lowCarb = "Low-Carb"
    case lowSodium = "Low-Sodium"
}

// MARK: - Filter State
class RecipeFilterState: ObservableObject {
    @Published var selectedCuisines: Set<Cuisine> = []
    @Published var selectedDifficulties: Set<Difficulty> = []
    @Published var selectedDietaryRestrictions: Set<DietaryRestriction> = []
    @Published var maxCookingTime: Double = 120
    @Published var minRating: Double = 0
    @Published var maxServings: Double = 10
    @Published var searchText: String = ""
    
    func clearAllFilters() {
        selectedCuisines.removeAll()
        selectedDifficulties.removeAll()
        selectedDietaryRestrictions.removeAll()
        maxCookingTime = 120
        minRating = 0
        maxServings = 10
        searchText = ""
    }
}