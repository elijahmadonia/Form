import SwiftUI

struct LeaderboardRow: View {
    let rank: Int
    let name: String
    let visits: Int
    let workoutsCompleted: Int
    let isHereNow: Bool
    var isHighlighted: Bool = false

    private var initials: String {
        let parts = name.split(separator: " ")
        let first = parts.first?.first.map(String.init) ?? ""
        let last = parts.dropFirst().first?.first.map(String.init) ?? ""
        return (first + last).uppercased()
    }

    var body: some View {
        HStack(spacing: AppSpacing.md) {
            Text("\(rank)")
                .font(AppTypography.caption)
                .foregroundColor(AppColors.textSecondary)
                .frame(width: 22, alignment: .leading)

            ZStack {
                Circle()
                    .fill(AppColors.surface)
                    .overlay(
                        Circle()
                            .stroke(AppColors.border, lineWidth: 1)
                    )
                Text(initials)
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.textPrimary)
            }
            .frame(width: 36, height: 36)

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text(name)
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textPrimary)

                Text("\(workoutsCompleted) workouts")
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.textSecondary)
            }

            if isHereNow {
                Text("Here now")
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.accent)
                    .padding(.horizontal, AppSpacing.sm)
                    .padding(.vertical, 4)
                    .background(AppColors.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppRadius.pill)
                            .stroke(AppColors.border, lineWidth: 1)
                    )
                    .cornerRadius(AppRadius.pill)
            }

            Spacer()

            Text("\(visits)")
                .font(AppTypography.headline)
                .foregroundColor(AppColors.textPrimary)
        }
        .padding(AppSpacing.md)
        .background(isHighlighted ? AppColors.surfaceElevated : AppColors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.md)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .cornerRadius(AppRadius.md)
    }
}

#Preview {
    VStack(spacing: AppSpacing.sm) {
        LeaderboardRow(rank: 1, name: "Nora R", visits: 18, workoutsCompleted: 32, isHereNow: true)
        LeaderboardRow(rank: 2, name: "Mr. Jawz", visits: 15, workoutsCompleted: 28, isHereNow: false)
        LeaderboardRow(rank: 4, name: "John Triv", visits: 10, workoutsCompleted: 21, isHereNow: true, isHighlighted: true)
    }
    .padding()
    .background(AppColors.background)
    .preferredColorScheme(.dark)
}
