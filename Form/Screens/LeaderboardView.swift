import SwiftUI

struct LeaderboardView: View {
    let entries: [LeaderboardEntry]

    private var sortedEntries: [LeaderboardEntry] {
        entries.sorted {
            if $0.visits == $1.visits { return $0.workoutsCompleted > $1.workoutsCompleted }
            return $0.visits > $1.visits
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                Text("Leaderboard")
                    .font(AppTypography.title)
                    .foregroundColor(AppColors.textPrimary)

                VStack(spacing: AppSpacing.sm) {
                    ForEach(sortedEntries.indices, id: \.self) { index in
                        let entry = sortedEntries[index]
                        LeaderboardRow(
                            rank: index + 1,
                            name: entry.name,
                            visits: entry.visits,
                            workoutsCompleted: entry.workoutsCompleted,
                            isHereNow: entry.isHereNow
                        )
                    }
                }
            }
            .padding(AppSpacing.lg)
        }
        .background(AppColors.background)
    }
}

#Preview {
    LeaderboardView(entries: SampleData.leaderboard)
        .preferredColorScheme(.dark)
}
