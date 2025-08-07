import SwiftUI

struct RecipeResultsView: View {
    @ObservedObject var filterState: RecipeFilterState
    @Environment(\.presentationMode) var presentationMode
    
    var filteredRecipes: [Recipe] {
        SampleData.recipes.filter { recipe in
            // Search text filter
            if !filterState.searchText.isEmpty {
                let searchMatch = recipe.name.localizedCaseInsensitiveContains(filterState.searchText) ||
                                recipe.ingredients.contains { ingredient in
                                    ingredient.localizedCaseInsensitiveContains(filterState.searchText)
                                }
                if !searchMatch {
                    return false
                }
            }
            
            // Cuisine filter
            if !filterState.selectedCuisines.isEmpty {
                if !filterState.selectedCuisines.contains(recipe.cuisine) {
                    return false
                }
            }
            
            // Difficulty filter
            if !filterState.selectedDifficulties.isEmpty {
                if !filterState.selectedDifficulties.contains(recipe.difficulty) {
                    return false
                }
            }
            
            // Dietary restrictions filter
            if !filterState.selectedDietaryRestrictions.isEmpty {
                let hasAllRestrictions = filterState.selectedDietaryRestrictions.allSatisfy { restriction in
                    recipe.dietaryRestrictions.contains(restriction)
                }
                if !hasAllRestrictions {
                    return false
                }
            }
            
            // Cooking time filter
            if recipe.cookingTime > Int(filterState.maxCookingTime) {
                return false
            }
            
            // Rating filter
            if recipe.rating < filterState.minRating {
                return false
            }
            
            // Servings filter
            if recipe.servings > Int(filterState.maxServings) {
                return false
            }
            
            return true
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if filteredRecipes.isEmpty {
                    emptyStateView
                } else {
                    resultsList
                }
            }
            .navigationTitle("Recipe Results")
            .navigationBarItems(
                leading: backButton,
                trailing: Text("\(filteredRecipes.count) recipes")
                    .font(.caption)
                    .foregroundColor(.secondary)
            )
        }
    }
    
    // MARK: - Results List
    private var resultsList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(filteredRecipes) { recipe in
                    RecipeCard(recipe: recipe)
                }
            }
            .padding()
        }
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: 24) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 64))
                .foregroundColor(.gray)
            
            VStack(spacing: 8) {
                Text("No Recipes Found")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Try adjusting your filters to find more recipes")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button("Clear Filters") {
                filterState.clearAllFilters()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
    
    // MARK: - Back Button
    private var backButton: some View {
        Button("Back") {
            presentationMode.wrappedValue.dismiss()
        }
        .foregroundColor(.blue)
    }
}

// MARK: - Recipe Card Component
struct RecipeCard: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(recipe.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    Text(recipe.cuisine.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    RatingView(rating: recipe.rating)
                    
                    Text(recipe.difficulty.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(difficultyColor(recipe.difficulty).opacity(0.2))
                        .foregroundColor(difficultyColor(recipe.difficulty))
                        .cornerRadius(6)
                }
            }
            
            // Description
            Text(recipe.description)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            // Recipe Details
            HStack(spacing: 20) {
                DetailItem(icon: "clock", text: "\(recipe.cookingTime) min")
                DetailItem(icon: "person.2", text: "\(recipe.servings) servings")
            }
            
            // Dietary Restrictions
            if !recipe.dietaryRestrictions.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(recipe.dietaryRestrictions, id: \.self) { restriction in
                            Text(restriction.rawValue)
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.2))
                                .foregroundColor(.green)
                                .cornerRadius(6)
                        }
                    }
                    .padding(.horizontal, 1)
                }
            }
            
            // Ingredients Preview
            VStack(alignment: .leading, spacing: 4) {
                Text("Ingredients:")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                
                Text(recipe.ingredients.prefix(3).joined(separator: ", ") + (recipe.ingredients.count > 3 ? "..." : ""))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private func difficultyColor(_ difficulty: Difficulty) -> Color {
        switch difficulty {
        case .easy:
            return .green
        case .medium:
            return .orange
        case .hard:
            return .red
        }
    }
}

// MARK: - Rating View Component
struct RatingView: View {
    let rating: Double
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                Image(systemName: starType(for: index))
                    .foregroundColor(.yellow)
                    .font(.caption)
            }
            
            Text(String(format: "%.1f", rating))
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
    
    private func starType(for index: Int) -> String {
        let position = Double(index + 1)
        if rating >= position {
            return "star.fill"
        } else if rating >= position - 0.5 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}

// MARK: - Detail Item Component
struct DetailItem: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.caption)
            
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    RecipeResultsView(filterState: RecipeFilterState())
}