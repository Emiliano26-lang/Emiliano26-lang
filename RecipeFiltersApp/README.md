# Recipe Filters App (SwiftUI)

A simple SwiftUI app that demonstrates a form-based filter UI for browsing recipes. Users can filter by search text, cuisine, difficulty, dietary restrictions, ingredients to include/exclude, cook time, rating, and sorting.

## Features
- Form sections for search, cuisine & difficulty, dietary restrictions, time & rating, ingredients, and sorting
- Live-updating filtered results list with sample data
- Reset button to clear all filters
- Modern SwiftUI components: `NavigationStack`, `Form`, `Section`, `Picker`, `Toggle`, `Slider`, `List`

## Project Structure
- `Models/Recipe.swift`: Recipe model, `Cuisine` and `Difficulty` enums, and sample data
- `ViewModels/RecipeFilterViewModel.swift`: Observable view model with filter state and computed `filteredRecipes`
- `Views/FilterFormView.swift`: The filter form UI and results list
- `Views/RecipeRowView.swift`: List row UI for a recipe
- `Views/ContentView.swift`: Hosts the filter screen
- `RecipeFiltersApp.swift`: App entry point

## Requirements
- Xcode 15 or newer
- iOS 17 SDK (you can lower the minimum target if needed; all used APIs exist since iOS 16, except `ContentUnavailableView` which you can replace for earlier versions)

## Running
1. Open Xcode and create a new iOS App project named "RecipeFiltersApp" (SwiftUI, Swift).
2. Replace the generated files with the ones in this folder, or drag the `RecipeFiltersApp` folder into your project.
3. Build and run on iOS Simulator.

Alternatively, you can create a Swift Package for the sources and preview the views in Xcode Previews.

## Notes
- Ingredient include/exclude fields accept comma-separated values. Matching is case-insensitive. Include requires all to be present; exclude removes any recipes containing any of the listed ingredients.
- Sorting options: Alphabetical, Cook Time, Rating; ascending toggle included.