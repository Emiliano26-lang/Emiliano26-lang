import SwiftUI

struct FilterFormView: View {
    @ObservedObject var viewModel: RecipeFilterViewModel

    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case includeIngredients
        case excludeIngredients
        case search
    }

    var body: some View {
        Form {
            Section("Search") {
                TextField("Search by title or ingredient", text: $viewModel.searchText)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($focusedField, equals: .search)
            }

            Section("Cuisine & Difficulty") {
                Picker("Cuisine", selection: $viewModel.selectedCuisine) {
                    Text("All").tag(Cuisine?.none)
                    ForEach(Cuisine.allCases) { cuisine in
                        Text(cuisine.displayName).tag(Cuisine?.some(cuisine))
                    }
                }

                Picker("Difficulty", selection: $viewModel.selectedDifficulty) {
                    Text("All").tag(Difficulty?.none)
                    ForEach(Difficulty.allCases) { difficulty in
                        Text(difficulty.displayName).tag(Difficulty?.some(difficulty))
                    }
                }
            }

            Section("Dietary") {
                Toggle("Vegan only", isOn: $viewModel.requireVegan)
                Toggle("Vegetarian only", isOn: $viewModel.requireVegetarian)
                Toggle("Gluten-free only", isOn: $viewModel.requireGlutenFree)
            }

            Section("Time & Rating") {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Max cook time")
                        Spacer()
                        Text("\(Int(viewModel.maxCookTimeMinutes)) min")
                            .foregroundStyle(.secondary)
                    }
                    Slider(value: $viewModel.maxCookTimeMinutes, in: 5...240, step: 5)
                }

                VStack(alignment: .leading) {
                    HStack {
                        Text("Min rating")
                        Spacer()
                        Text(String(format: "%.1f", viewModel.minRating))
                            .foregroundStyle(.secondary)
                    }
                    Slider(value: $viewModel.minRating, in: 0...5, step: 0.5)
                }
            }

            Section("Ingredients") {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Include (comma-separated)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    TextField("e.g. tomato, basil", text: $viewModel.includeIngredientsCSV)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .focused($focusedField, equals: .includeIngredients)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Exclude (comma-separated)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    TextField("e.g. peanuts, gluten", text: $viewModel.excludeIngredientsCSV)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .focused($focusedField, equals: .excludeIngredients)
                }
            }

            Section("Sort") {
                Picker("Sort by", selection: $viewModel.sortOption) {
                    ForEach(SortOption.allCases) { option in
                        Text(option.displayName).tag(option)
                    }
                }
                Toggle("Ascending", isOn: $viewModel.sortAscending)
            }

            Section {
                HStack {
                    Text("Results")
                        .font(.headline)
                    Spacer()
                    Text("\(viewModel.filteredRecipes.count)")
                        .foregroundStyle(.secondary)
                }
            }

            Section {
                if viewModel.filteredRecipes.isEmpty {
                    ContentUnavailableView(
                        "No recipes",
                        systemImage: "magnifyingglass",
                        description: Text("Try adjusting your filters.")
                    )
                } else {
                    ForEach(viewModel.filteredRecipes) { recipe in
                        RecipeRowView(recipe: recipe)
                    }
                }
            }
        }
        .navigationTitle("Filters")
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Reset") { viewModel.resetFilters() }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FilterFormView(viewModel: RecipeFilterViewModel())
    }
}