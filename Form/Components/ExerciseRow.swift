import SwiftUI

struct ExerciseRow: View {
    let exercise: Exercise

    var body: some View {
        HStack(spacing: AppSpacing.md) {
            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text(exercise.name)
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textPrimary)

                Text("\(exercise.sets) sets • \(exercise.reps)")
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.textSecondary)
            }

            Spacer()

            Text(exercise.equipment)
                .font(AppTypography.caption)
                .foregroundColor(AppColors.tagText)
                .padding(.horizontal, AppSpacing.sm)
                .padding(.vertical, 6)
                .background(AppColors.tagBackground.opacity(0.7))
                .cornerRadius(AppRadius.pill)
        }
        .padding(AppSpacing.md)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.lg)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .cornerRadius(AppRadius.lg)
    }
}

#Preview {
    ExerciseRow(exercise: SampleData.workouts[1].exercises[0])
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}
