import SwiftUI

struct EmptyState: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: AppSpacing.sm) {
            Image(systemName: "figure.walk")
                .font(.system(size: 36, weight: .semibold))
                .foregroundColor(AppColors.accent)

            Text(title)
                .font(AppTypography.headline)
                .foregroundColor(AppColors.textPrimary)

            Text(subtitle)
                .font(AppTypography.body)
                .foregroundColor(AppColors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(AppSpacing.xl)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.lg)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .cornerRadius(AppRadius.lg)
    }
}

#Preview {
    EmptyState(title: "No workouts yet", subtitle: "Try a different category or add a workout.")
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}
