import SwiftUI

struct AnalysisView: View {
    @Environment(AnalysisViewModel.self) private var viewModel
    @State private var showCamera = false

    var body: some View {
        NavigationView {
            VStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
                if viewModel.isLoading {
                    ProgressView()
                }
                List {
                    ForEach($viewModel.ingredients) { $ingredient in
                        HStack {
                            TextField("Name", text: $ingredient.name)
                            Spacer()
                            TextField("Calories", value: $ingredient.calories, format: .number)
                                .keyboardType(.decimalPad)
                        }
                    }
                }
                Text("Total: \(viewModel.ingredients.reduce(0) { $0 + $1.calories }, format: .number) cal")
                    .padding()
                Button("Save Entry") {
                    viewModel.saveCurrentEntry()
                }
                .padding()
            }
            .navigationTitle("Food Analysis")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showCamera = true }) {
                        Image(systemName: "camera")
                    }
                }
            }
            .sheet(isPresented: $showCamera) {
                CameraView()
                    .environment(viewModel)
            }
        }
    }
}
