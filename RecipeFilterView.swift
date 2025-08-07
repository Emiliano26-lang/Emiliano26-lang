import SwiftUI

struct RecipeFilterView: View {
    @StateObject private var filterState = RecipeFilterState()
    @State private var showingResults = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Search Bar
                    searchSection
                    
                    // Cuisine Filter
                    cuisineSection
                    
                    // Difficulty Filter
                    difficultySection
                    
                    // Dietary Restrictions
                    dietarySection
                    
                    // Cooking Time Slider
                    cookingTimeSection
                    
                    // Rating Slider
                    ratingSection
                    
                    // Servings Slider
                    servingsSection
                    
                    // Action Buttons
                    actionButtons
                }
                .padding()
            }
            .navigationTitle("Recipe Filters")
            .navigationBarItems(trailing: clearButton)
            .sheet(isPresented: $showingResults) {
                RecipeResultsView(filterState: filterState)
            }
        }
    }
    
    // MARK: - Search Section
    private var searchSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Search Recipes")
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search by name or ingredient...", text: $filterState.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
    }
    
    // MARK: - Cuisine Section
    private var cuisineSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Cuisine Type")
                .font(.headline)
                .foregroundColor(.primary)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                ForEach(Cuisine.allCases, id: \.self) { cuisine in
                    FilterChip(
                        title: cuisine.rawValue,
                        isSelected: filterState.selectedCuisines.contains(cuisine)
                    ) {
                        toggleCuisineSelection(cuisine)
                    }
                }
            }
        }
    }
    
    // MARK: - Difficulty Section
    private var difficultySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Difficulty Level")
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack(spacing: 12) {
                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                    FilterChip(
                        title: difficulty.rawValue,
                        isSelected: filterState.selectedDifficulties.contains(difficulty)
                    ) {
                        toggleDifficultySelection(difficulty)
                    }
                }
            }
        }
    }
    
    // MARK: - Dietary Section
    private var dietarySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Dietary Restrictions")
                .font(.headline)
                .foregroundColor(.primary)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                ForEach(DietaryRestriction.allCases, id: \.self) { restriction in
                    FilterChip(
                        title: restriction.rawValue,
                        isSelected: filterState.selectedDietaryRestrictions.contains(restriction)
                    ) {
                        toggleDietaryRestriction(restriction)
                    }
                }
            }
        }
    }
    
    // MARK: - Cooking Time Section
    private var cookingTimeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Max Cooking Time")
                    .font(.headline)
                Spacer()
                Text("\(Int(filterState.maxCookingTime)) min")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            
            Slider(value: $filterState.maxCookingTime, in: 5...120, step: 5)
                .accentColor(.blue)
        }
    }
    
    // MARK: - Rating Section
    private var ratingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Minimum Rating")
                    .font(.headline)
                Spacer()
                HStack(spacing: 2) {
                    ForEach(0..<Int(filterState.minRating), id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                    if filterState.minRating.truncatingRemainder(dividingBy: 1) > 0 {
                        Image(systemName: "star.leadinghalf.filled")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                    Text(String(format: "%.1f", filterState.minRating))
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
            }
            
            Slider(value: $filterState.minRating, in: 0...5, step: 0.5)
                .accentColor(.yellow)
        }
    }
    
    // MARK: - Servings Section
    private var servingsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Max Servings")
                    .font(.headline)
                Spacer()
                Text("\(Int(filterState.maxServings)) people")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            
            Slider(value: $filterState.maxServings, in: 1...10, step: 1)
                .accentColor(.green)
        }
    }
    
    // MARK: - Action Buttons
    private var actionButtons: some View {
        VStack(spacing: 12) {
            Button(action: {
                showingResults = true
            }) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Find Recipes")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            Button(action: {
                filterState.clearAllFilters()
            }) {
                HStack {
                    Image(systemName: "clear")
                    Text("Clear All Filters")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.secondary)
                .cornerRadius(10)
            }
        }
    }
    
    // MARK: - Clear Button
    private var clearButton: some View {
        Button("Clear") {
            filterState.clearAllFilters()
        }
        .foregroundColor(.blue)
    }
    
    // MARK: - Helper Methods
    private func toggleCuisineSelection(_ cuisine: Cuisine) {
        if filterState.selectedCuisines.contains(cuisine) {
            filterState.selectedCuisines.remove(cuisine)
        } else {
            filterState.selectedCuisines.insert(cuisine)
        }
    }
    
    private func toggleDifficultySelection(_ difficulty: Difficulty) {
        if filterState.selectedDifficulties.contains(difficulty) {
            filterState.selectedDifficulties.remove(difficulty)
        } else {
            filterState.selectedDifficulties.insert(difficulty)
        }
    }
    
    private func toggleDietaryRestriction(_ restriction: DietaryRestriction) {
        if filterState.selectedDietaryRestrictions.contains(restriction) {
            filterState.selectedDietaryRestrictions.remove(restriction)
        } else {
            filterState.selectedDietaryRestrictions.insert(restriction)
        }
    }
}

// MARK: - Filter Chip Component
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(16)
        }
    }
}

#Preview {
    RecipeFilterView()
}