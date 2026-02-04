import SwiftUI

struct WorkoutDetailView: View {
    let workout: Workout
    private let columns = [
        GridItem(.flexible(), spacing: AppSpacing.md),
        GridItem(.flexible(), spacing: AppSpacing.md)
    ]

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text(workout.title)
                            .font(AppTypography.title)
                            .foregroundColor(AppColors.textPrimary)

                        Text("\(workout.durationMinutes) min • \(workout.difficulty) • \(workout.category.displayName)")
                            .font(AppTypography.body)
                            .foregroundColor(AppColors.textSecondary)
                    }

                    PrimaryButton(title: "Start Workout") {}

                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        SectionHeader(title: "Exercises")

                        LazyVGrid(columns: columns, spacing: AppSpacing.md) {
                            ForEach(workout.exercises) { exercise in
                                SquareTile(
                                    title: exercise.name,
                                    subtitle: "\(exercise.sets) sets • \(exercise.reps)",
                                    systemImageName: "figure.strengthtraining.traditional",
                                    imageName: exercise.imageName
                                )
                            }
                        }
                    }
                }
                .padding(AppSpacing.lg)
            }
        }
        .navigationTitle("Workout")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

#Preview {
    NavigationStack {
        WorkoutDetailView(workout: SampleData.workouts[0])
    }
}
