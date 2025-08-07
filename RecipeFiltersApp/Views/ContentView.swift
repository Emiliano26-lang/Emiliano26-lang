import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecipeFilterViewModel()

    var body: some View {
        NavigationStack {
            FilterFormView(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView()
}