import SwiftUI

struct SectionHeader: View {
    let title: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(title)
                .font(AppTypography.headline)
                .foregroundColor(AppColors.textPrimary)

            Spacer()

            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.accent)
                    .padding(.horizontal, AppSpacing.sm)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppRadius.pill)
                            .stroke(AppColors.border, lineWidth: 1)
                    )
                    .cornerRadius(AppRadius.pill)
            }
        }
    }
}

#Preview {
    SectionHeader(title: "Workouts", actionTitle: "See all") {}
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}
