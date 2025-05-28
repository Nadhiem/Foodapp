import SwiftUI

@main
struct CalorieApp: App {
    @StateObject private var viewModel = AnalysisViewModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                AnalysisView()
                    .tabItem {
                        Label("Analyze", systemImage: "camera.viewfinder")
                    }
                    .environmentObject(viewModel)
                NavigationView {
                    HistoryView()
                }
                .tabItem {
                    Label("History", systemImage: "calendar")
                }
            }
        }
    }
}
