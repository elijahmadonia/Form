import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            WorkoutsView()
                .tabItem {
                    Label("Workouts", systemImage: "figure.strengthtraining.traditional")
                }

            ShopView()
                .tabItem {
                    Label("Shop", systemImage: "bag.fill")
                }

            ComponentLibraryView()
                .tabItem {
                    Label("Components", systemImage: "square.grid.2x2")
                }
        }
        .tint(AppColors.accent)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
