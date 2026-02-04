import SwiftUI

struct ActivityView: View {
    let visits: [Visit]

    private var totalVisits: Int { visits.count }
    private var totalWorkouts: Int { visits.reduce(0) { $0 + $1.workoutsCompleted } }
    private var totalMinutes: Int { visits.reduce(0) { $0 + $1.durationMinutes } }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                Text("Activity")
                    .font(AppTypography.title)
                    .foregroundColor(AppColors.textPrimary)

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    StatRow(label: "Visits this month", value: "\(totalVisits)")
                    StatRow(label: "Workouts completed", value: "\(totalWorkouts)")
                    StatRow(label: "Minutes in gym", value: "\(totalMinutes)")
                }
                .padding(AppSpacing.lg)
                .background(AppColors.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: AppRadius.lg)
                        .stroke(AppColors.border, lineWidth: 1)
                )
                .cornerRadius(AppRadius.lg)

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text("Recent visits")
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.textPrimary)

                    ForEach(visits) { visit in
                        VisitRow(visit: visit)
                    }
                }
            }
            .padding(AppSpacing.lg)
        }
        .background(AppColors.background)
    }
}

private struct StatRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(AppTypography.body)
                .foregroundColor(AppColors.textSecondary)
            Spacer()
            Text(value)
                .font(AppTypography.headline)
                .foregroundColor(AppColors.textPrimary)
        }
    }
}

private struct VisitRow: View {
    let visit: Visit

    private var dateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: visit.date)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text(dateText)
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textPrimary)
                Text("\(visit.durationMinutes) min • \(visit.workoutsCompleted) workouts")
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.textSecondary)
            }
            Spacer()
        }
        .padding(AppSpacing.md)
        .background(AppColors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.md)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .cornerRadius(AppRadius.md)
    }
}

#Preview {
    ActivityView(visits: SampleData.visits)
        .preferredColorScheme(.dark)
}
