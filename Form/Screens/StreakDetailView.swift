import SwiftUI

struct StreakDetailView: View {
    let monthDate: Date
    let activeDays: Set<Int>
    private let calendar = Calendar.current

    private var streakCount: Int {
        let today = calendar.component(.day, from: Date())
        var count = 0
        var day = today
        while activeDays.contains(day) && day > 0 {
            count += 1
            day -= 1
        }
        return count
    }

    private var recentMonths: [Date] {
        (0...8).compactMap { calendar.date(byAdding: .month, value: -$0, to: monthDate) }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                HStack(alignment: .center, spacing: AppSpacing.md) {
                    VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                        Text("\(streakCount)")
                            .font(.system(size: 56, weight: .bold, design: .rounded))
                            .foregroundColor(AppColors.textPrimary)

                        Text("day streak")
                            .font(AppTypography.body)
                            .foregroundColor(AppColors.textSecondary)
                    }

                    Spacer()

                    Image(systemName: "flame.fill")
                        .font(.system(size: 56, weight: .semibold))
                        .foregroundColor(AppColors.accent)
                        .padding(AppSpacing.sm)
                        .background(AppColors.surface)
                        .clipShape(Circle())
                }

                StreakMonthCarousel(months: recentMonths) { _ in activeDays }
            }
            .padding(AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle("Streak")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

#Preview {
    NavigationStack {
        StreakDetailView(
            monthDate: Date(),
            activeDays: [1, 2, 3, 5, 7, 12, 13, 18, 22, 24, 27]
        )
    }
    .preferredColorScheme(.dark)
}
