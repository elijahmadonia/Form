import SwiftUI

struct ComponentLibraryView: View {
    private let sampleWorkout = SampleData.workouts[1]
    private let sampleExercise = SampleData.workouts[1].exercises[0]
    private let activeDays: Set<Int> = [1, 2, 3, 5, 7]

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    Text("Component Library")
                        .font(AppTypography.title)
                        .foregroundColor(AppColors.textPrimary)

                    Text("Live previews of reusable UI pieces.")
                        .font(AppTypography.body)
                        .foregroundColor(AppColors.textSecondary)

                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        SectionHeader(title: "Buttons")
                        PrimaryButton(title: "Start Workout") {}
                    }

                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        SectionHeader(title: "Category Pills")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: AppSpacing.sm) {
                                ForEach(Category.allCases) { category in
                                    CategoryPill(category: category, isSelected: category == .strength) {}
                                }
                            }
                        }
                    }

                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    SectionHeader(title: "Cards")
                    WorkoutCard(workout: sampleWorkout)
                }

                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    SectionHeader(title: "Rows")
                    ExerciseRow(exercise: sampleExercise)
                }

                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    SectionHeader(title: "Tiles")
                    SquareTile(
                        title: sampleExercise.name,
                        subtitle: "\(sampleExercise.sets) sets • \(sampleExercise.reps)",
                        systemImageName: "figure.strengthtraining.traditional",
                        imageName: sampleExercise.imageName
                    )
                }

                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    SectionHeader(title: "Streak Calendar")
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        StreakWeekdayRow()
                        StreakMonthGrid(monthDate: Date(), activeDays: activeDays)
                    }
                    .padding(AppSpacing.lg)
                    .background(AppColors.surface)
                    .cornerRadius(AppRadius.lg)
                }

                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    SectionHeader(title: "Leaderboard Row")
                    LeaderboardRow(rank: 1, name: "Nora R", visits: 18, workoutsCompleted: 32, isHereNow: true)
                    LeaderboardRow(rank: 2, name: "Mr. Jawz", visits: 15, workoutsCompleted: 28, isHereNow: false)
                }

                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    SectionHeader(title: "Empty State")
                    EmptyState(title: "No workouts", subtitle: "Try another category or add a new workout.")
                }
            }
                .padding(AppSpacing.lg)
            }
        }
    }
}

#Preview {
    ComponentLibraryView()
}
