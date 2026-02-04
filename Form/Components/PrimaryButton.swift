import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTypography.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppSpacing.md)
                .background(AppColors.accent)
                .overlay(
                    RoundedRectangle(cornerRadius: AppRadius.lg)
                        .stroke(Color.white.opacity(0.18), lineWidth: 1)
                )
                .cornerRadius(AppRadius.lg)
        }
    }
}

#Preview {
    PrimaryButton(title: "Start Workout") {}
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}
