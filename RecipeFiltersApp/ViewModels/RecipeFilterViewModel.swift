import Foundation
import Combine

public enum SortOption: String, CaseIterable, Identifiable {
    case alphabetical
    case cookTime
    case rating

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .alphabetical: return "Alphabetical"
        case .cookTime: return "Cook Time"
        case .rating: return "Rating"
        }
    }
}

public final class RecipeFilterViewModel: ObservableObject {
    // Input data
    @Published public private(set) var recipes: [Recipe]

    // Filters
    @Published public var searchText: String = ""
    @Published public var selectedCuisine: Cuisine? = nil // nil means All
    @Published public var selectedDifficulty: Difficulty? = nil // nil means All
    @Published public var maxCookTimeMinutes: Double = 120

    // Ingredient filters are edited as CSV text fields for a simple UX
    @Published public var includeIngredientsCSV: String = ""
    @Published public var excludeIngredientsCSV: String = ""

    @Published public var requireVegan: Bool = false
    @Published public var requireVegetarian: Bool = false
    @Published public var requireGlutenFree: Bool = false

    @Published public var minRating: Double = 0

    @Published public var sortOption: SortOption = .alphabetical
    @Published public var sortAscending: Bool = true

    public init(recipes: [Recipe] = Recipe.sample) {
        self.recipes = recipes
    }

    public var includeIngredients: Set<String> {
        Set(parseCSV(includeIngredientsCSV))
    }

    public var excludeIngredients: Set<String> {
        Set(parseCSV(excludeIngredientsCSV))
    }

    public var filteredRecipes: [Recipe] {
        let loweredSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let include = includeIngredients
        let exclude = excludeIngredients

        let filtered = recipes.filter { recipe in
            // Search in title or ingredients
            if !loweredSearch.isEmpty {
                let matchesTitle = recipe.title.lowercased().contains(loweredSearch)
                let matchesIngredient = recipe.ingredients.contains { $0.lowercased().contains(loweredSearch) }
                if !(matchesTitle || matchesIngredient) { return false }
            }

            // Cuisine
            if let selectedCuisine { if recipe.cuisine != selectedCuisine { return false } }

            // Difficulty
            if let selectedDifficulty { if recipe.difficulty != selectedDifficulty { return false } }

            // Cook time
            if recipe.cookTimeMinutes > Int(maxCookTimeMinutes.rounded()) { return false }

            // Dietary
            if requireVegan && recipe.isVegan == false { return false }
            if requireVegetarian && recipe.isVegetarian == false { return false }
            if requireGlutenFree && recipe.isGlutenFree == false { return false }

            // Rating
            if recipe.ratingOutOfFive < minRating { return false }

            // Include ingredients: all must be present
            if include.isEmpty == false {
                let recipeIngredients = Set(recipe.ingredients.map { $0.lowercased() })
                if !include.isSubset(of: recipeIngredients) { return false }
            }

            // Exclude ingredients: none must be present
            if exclude.isEmpty == false {
                let recipeIngredients = Set(recipe.ingredients.map { $0.lowercased() })
                if !exclude.isDisjoint(with: recipeIngredients) { return false }
            }

            return true
        }

        let sorted: [Recipe]
        switch sortOption {
        case .alphabetical:
            sorted = filtered.sorted { a, b in
                sortAscending ? a.title.localizedCaseInsensitiveCompare(b.title) == .orderedAscending : a.title.localizedCaseInsensitiveCompare(b.title) == .orderedDescending
            }
        case .cookTime:
            sorted = filtered.sorted { a, b in
                sortAscending ? a.cookTimeMinutes < b.cookTimeMinutes : a.cookTimeMinutes > b.cookTimeMinutes
            }
        case .rating:
            sorted = filtered.sorted { a, b in
                sortAscending ? a.ratingOutOfFive < b.ratingOutOfFive : a.ratingOutOfFive > b.ratingOutOfFive
            }
        }

        return sorted
    }

    public func resetFilters() {
        searchText = ""
        selectedCuisine = nil
        selectedDifficulty = nil
        maxCookTimeMinutes = 120
        includeIngredientsCSV = ""
        excludeIngredientsCSV = ""
        requireVegan = false
        requireVegetarian = false
        requireGlutenFree = false
        minRating = 0
        sortOption = .alphabetical
        sortAscending = true
    }

    private func parseCSV(_ raw: String) -> [String] {
        raw
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
            .filter { $0.isEmpty == false }
    }
}