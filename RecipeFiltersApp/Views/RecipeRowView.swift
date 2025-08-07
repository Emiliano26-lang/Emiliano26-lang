import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(recipe.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                    Spacer(minLength: 0)
                }

                HStack(spacing: 8) {
                    Label("\(recipe.cookTimeMinutes)m", systemImage: "timer")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(recipe.cuisine.displayName)
                        .font(.subheadline)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.systemGray6))
                        .clipShape(Capsule())
                        .foregroundStyle(.secondary)
                    Text(recipe.difficulty.displayName)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 2) {
                    ForEach(0..<5, id: \.self) { idx in
                        Image(systemName: idx < Int(recipe.ratingOutOfFive.rounded()) ? "star.fill" : "star")
                            .foregroundStyle(.yellow)
                    }
                    Spacer()
                }
            }
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    RecipeRowView(recipe: Recipe.sample.first!)
        .padding()
}