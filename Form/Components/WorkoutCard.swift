import SwiftUI

struct WorkoutCard: View {
    let workout: Workout

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text(workout.title)
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.textPrimary)

                    Text("\(workout.durationMinutes) min • \(workout.difficulty)")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textSecondary)
                }

                Spacer()

                Circle()
                    .fill(workout.category.color)
                    .frame(width: 10, height: 10)
            }

            HStack(spacing: AppSpacing.xs) {
                Tag(text: workout.category.displayName)
                Tag(text: workout.exercises.first?.equipment ?? "Bodyweight")
            }
        }
        .padding(AppSpacing.md)
        .background(AppColors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.lg)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .cornerRadius(AppRadius.lg)
    }
}

private struct Tag: View {
    let text: String

    var body: some View {
        Text(text)
            .font(AppTypography.caption)
            .foregroundColor(AppColors.tagText)
            .padding(.horizontal, AppSpacing.sm)
            .padding(.vertical, 6)
            .background(AppColors.tagBackground.opacity(0.7))
            .cornerRadius(AppRadius.pill)
    }
}

#Preview {
    WorkoutCard(workout: SampleData.workouts[0])
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}
