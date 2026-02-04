import SwiftUI

struct HomeView: View {
    private let monthDate = Date()
    private let activeDays: Set<Int> = [1, 2, 3, 5, 7, 12, 13, 18, 22, 24, 27]
    private let gymStatus = SampleData.gymStatus
    private let bays = SampleData.bays
    private let visits = SampleData.visits
    private let leaderboard = SampleData.leaderboard
    private let points = SampleData.points
    private let membership = SampleData.membership
    @State private var showProfile = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    Text("Home")
                        .font(AppTypography.title)
                        .foregroundColor(AppColors.textPrimary)

                    NavigationLink {
                        StreakDetailView(monthDate: monthDate, activeDays: activeDays)
                    } label: {
                        StreakSummaryCard(monthDate: monthDate, activeDays: activeDays)
                    }
                    .buttonStyle(.plain)

                    CombinedStatusCard(status: gymStatus, bays: bays, isDetected: true)

                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        HStack {
                            Text("Activity")
                                .font(AppTypography.headline)
                                .foregroundColor(AppColors.textPrimary)

                            Spacer()

                            NavigationLink {
                                ActivityView(visits: visits)
                            } label: {
                                Text("See all")
                                    .font(AppTypography.caption)
                                    .foregroundColor(AppColors.accent)
                                    .padding(.horizontal, AppSpacing.sm)
                                    .padding(.vertical, 6)
                                    .background(AppColors.surface)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: AppRadius.pill)
                                            .stroke(AppColors.border, lineWidth: 1)
                                    )
                                    .cornerRadius(AppRadius.pill)
                            }
                            .buttonStyle(.plain)
                        }
                        ActivitySnapshotCard(visits: visits)
                    }

                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        HStack {
                            Text("Leaderboard")
                                .font(AppTypography.headline)
                                .foregroundColor(AppColors.textPrimary)

                            Spacer()

                            NavigationLink {
                                LeaderboardView(entries: leaderboard)
                            } label: {
                                Text("View all")
                                    .font(AppTypography.caption)
                                    .foregroundColor(AppColors.accent)
                                    .padding(.horizontal, AppSpacing.sm)
                                    .padding(.vertical, 6)
                                    .background(AppColors.surface)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: AppRadius.pill)
                                            .stroke(AppColors.border, lineWidth: 1)
                                    )
                                    .cornerRadius(AppRadius.pill)
                            }
                            .buttonStyle(.plain)
                        }
                        LeaderboardPreview(entries: Array(leaderboard.prefix(3)))
                    }
                }
                .padding(AppSpacing.lg)
            }
            .background(AppColors.background)
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showProfile = true
                    } label: {
                        Text("EM")
                            .font(AppTypography.caption)
                            .foregroundColor(AppColors.textPrimary)
                            .frame(width: 32, height: 32)
                            .background(AppColors.surface)
                            .overlay(
                                Circle().stroke(AppColors.border, lineWidth: 1)
                            )
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .sheet(isPresented: $showProfile) {
            ProfileCardView(
                membership: membership,
                points: points,
                visits: visits
            )
            .presentationDetents([.medium])
        }
    }
}

private struct CombinedStatusCard: View {
    let status: GymStatus
    let bays: [Bay]
    let isDetected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                    Text("Available")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textSecondary)

                    Text("\(status.availableBays) / \(status.totalBays)")
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.textPrimary)
                }

                Spacer()

                VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                    Text("People in gym")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textSecondary)

                    Text("\(status.peopleInGym)")
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.textPrimary)
                }
            }

            BayMapGrid(bays: bays)

            Divider()
                .overlay(AppColors.border)

            HStack(spacing: AppSpacing.md) {
                VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                    Text("Check-in")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textSecondary)

                    Text(isDetected ? "Detected" : "Not detected")
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.textPrimary)
                }

                Spacer()

                Button(action: {}) {
                    Text("Check in")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textSecondary)
                        .padding(.horizontal, AppSpacing.md)
                        .padding(.vertical, 8)
                        .background(AppColors.surface)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppRadius.pill)
                                .stroke(AppColors.border, lineWidth: 1)
                        )
                        .cornerRadius(AppRadius.pill)
                }
                .buttonStyle(.plain)
                .disabled(true)
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.lg)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .cornerRadius(AppRadius.lg)
    }
}

private struct BayMapGrid: View {
    let bays: [Bay]

    private let columns = [
        GridItem(.flexible(), spacing: AppSpacing.sm),
        GridItem(.flexible(), spacing: AppSpacing.sm),
        GridItem(.flexible(), spacing: AppSpacing.sm),
        GridItem(.flexible(), spacing: AppSpacing.sm)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: AppSpacing.sm) {
            ForEach(bays) { bay in
                NavigationLink {
                    BayDetailView(bay: bay)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: AppRadius.sm)
                            .fill(bay.isOccupied ? AppColors.surface : AppColors.accent)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppRadius.sm)
                                    .stroke(AppColors.border, lineWidth: 1)
                            )

                        Text(bay.name)
                            .font(AppTypography.caption)
                            .foregroundColor(bay.isOccupied ? AppColors.textSecondary : .black)
                    }
                    .frame(height: 44)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

private struct ActivitySnapshotCard: View {
    let visits: [Visit]

    private var totalVisits: Int { visits.count }
    private var totalWorkouts: Int { visits.reduce(0) { $0 + $1.workoutsCompleted } }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text("Visits this month")
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.textSecondary)
                Text("\(totalVisits)")
                    .font(AppTypography.headline)
                    .foregroundColor(AppColors.textPrimary)
            }

            Spacer()

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text("Workouts completed")
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.textSecondary)
                Text("\(totalWorkouts)")
                    .font(AppTypography.headline)
                    .foregroundColor(AppColors.textPrimary)
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.lg)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .cornerRadius(AppRadius.lg)
    }
}

private struct LeaderboardPreview: View {
    let entries: [LeaderboardEntry]

    var body: some View {
        VStack(spacing: AppSpacing.sm) {
            ForEach(entries.indices, id: \.self) { index in
                let entry = entries[index]
                LeaderboardRow(
                    rank: index + 1,
                    name: entry.name,
                    visits: entry.visits,
                    workoutsCompleted: entry.workoutsCompleted,
                    isHereNow: entry.isHereNow
                )
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.lg)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .cornerRadius(AppRadius.lg)
    }
}

private struct StreakSummaryCard: View {
    let monthDate: Date
    let activeDays: Set<Int>

    private var streakCount: Int {
        let calendar = Calendar.current
        let today = calendar.component(.day, from: Date())
        var count = 0
        var day = today
        while activeDays.contains(day) && day > 0 {
            count += 1
            day -= 1
        }
        return count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack(alignment: .center, spacing: AppSpacing.md) {
                VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                    Text("\(streakCount)")
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                        .foregroundColor(AppColors.textPrimary)

                    Text("day streak")
                        .font(AppTypography.body)
                        .foregroundColor(AppColors.textSecondary)
                }

                Spacer()

                Image(systemName: "flame.fill")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(AppColors.accent)
                    .padding(AppSpacing.sm)
                    .background(AppColors.surface)
                    .clipShape(Circle())
            }

            Rectangle()
                .fill(AppColors.border)
                .frame(height: 1)

            StreakWeekPreview(referenceDate: monthDate, activeDays: activeDays)
        }
        .padding(AppSpacing.lg)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.lg)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .cornerRadius(AppRadius.lg)
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}

private struct ProfileCardView: View {
    let membership: Membership
    let points: PointsAccount
    let visits: [Visit]

    private var totalVisits: Int { visits.count }
    private var totalWorkouts: Int { visits.reduce(0) { $0 + $1.workoutsCompleted } }
    private var renewalText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: membership.renewalDate)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.lg) {
            HStack {
                Text("Profile")
                    .font(AppTypography.headline)
                    .foregroundColor(AppColors.textPrimary)
                Spacer()
            }

            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                Text("Membership")
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.textSecondary)

                Text(membership.planName)
                    .font(AppTypography.headline)
                    .foregroundColor(AppColors.textPrimary)

                Text("\(membership.status) • Renews \(renewalText)")
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.textSecondary)
            }
            .padding(AppSpacing.lg)
            .background(AppColors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.lg)
                    .stroke(AppColors.border, lineWidth: 1)
            )
            .cornerRadius(AppRadius.lg)

            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                Text("Stats")
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.textSecondary)

                HStack {
                    VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                        Text("Visits")
                            .font(AppTypography.caption)
                            .foregroundColor(AppColors.textSecondary)
                        Text("\(totalVisits)")
                            .font(AppTypography.headline)
                            .foregroundColor(AppColors.textPrimary)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                        Text("Workouts")
                            .font(AppTypography.caption)
                            .foregroundColor(AppColors.textSecondary)
                        Text("\(totalWorkouts)")
                            .font(AppTypography.headline)
                            .foregroundColor(AppColors.textPrimary)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                        Text("Points")
                            .font(AppTypography.caption)
                            .foregroundColor(AppColors.textSecondary)
                        Text("\(points.balance)")
                            .font(AppTypography.headline)
                            .foregroundColor(AppColors.textPrimary)
                    }
                }
            }
            .padding(AppSpacing.lg)
            .background(AppColors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.lg)
                    .stroke(AppColors.border, lineWidth: 1)
            )
            .cornerRadius(AppRadius.lg)

            Spacer()
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
        .preferredColorScheme(.dark)
    }
}
