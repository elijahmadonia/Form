import SwiftUI

struct WorkoutsView: View {
    @State private var selectedCategory: Category = .mobility
    private let workouts = SampleData.workouts

    private var filteredWorkouts: [Workout] {
        workouts.filter { $0.category == selectedCategory }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: AppSpacing.lg) {
                        VStack(alignment: .leading, spacing: AppSpacing.xs) {
                            Text("Workouts")
                                .font(AppTypography.title)
                                .foregroundColor(AppColors.textPrimary)

                            Text("Choose a category to explore workouts and exercises.")
                                .font(AppTypography.body)
                                .foregroundColor(AppColors.textSecondary)
                        }
                        .padding(.horizontal, AppSpacing.lg)
                        .padding(.top, AppSpacing.lg)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: AppSpacing.sm) {
                                ForEach(Category.allCases) { category in
                                    CategoryPill(category: category, isSelected: category == selectedCategory) {
                                        selectedCategory = category
                                    }
                                }
                            }
                            .padding(.horizontal, AppSpacing.lg)
                        }

                        VStack(alignment: .leading, spacing: AppSpacing.md) {
                            SectionHeader(title: "Featured")

                            if filteredWorkouts.isEmpty {
                                EmptyState(title: "No workouts", subtitle: "Try another category or add a new workout.")
                            } else {
                                ForEach(filteredWorkouts) { workout in
                                    NavigationLink(value: workout) {
                                        WorkoutCard(workout: workout)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(.horizontal, AppSpacing.lg)
                        .padding(.bottom, AppSpacing.xl)
                    }
                }
            }
            .navigationDestination(for: Workout.self) { workout in
                WorkoutDetailView(workout: workout)
            }
        }
    }
}

#Preview {
    WorkoutsView()
}
