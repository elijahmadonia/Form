import SwiftUI

struct SquareTile: View {
    let title: String
    let subtitle: String
    let systemImageName: String
    let imageName: String?

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            TileImage(systemImageName: systemImageName, imageName: imageName)
                .frame(maxWidth: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.md))

            Text(title)
                .font(AppTypography.body)
                .foregroundColor(AppColors.textPrimary)
                .lineLimit(2)

            Text(subtitle)
                .font(AppTypography.caption)
                .foregroundColor(AppColors.textSecondary)
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

private struct TileImage: View {
    let systemImageName: String
    let imageName: String?

    var body: some View {
        Group {
#if os(iOS)
            if let imageName,
               let image = UIImage(named: imageName) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                PlaceholderTileImage(systemImageName: systemImageName)
            }
#else
            PlaceholderTileImage(systemImageName: systemImageName)
#endif
        }
    }
}

private struct PlaceholderTileImage: View {
    let systemImageName: String

    var body: some View {
        RoundedRectangle(cornerRadius: AppRadius.md)
            .fill(AppColors.surface)
            .overlay(
                Image(systemName: systemImageName)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(AppColors.textSecondary)
            )
    }
}

#Preview {
    SquareTile(
        title: "Back Squat",
        subtitle: "4 sets • 6 reps",
        systemImageName: "figure.strengthtraining.traditional",
        imageName: nil
    )
    .padding()
    .background(AppColors.background)
    .preferredColorScheme(.dark)
}
