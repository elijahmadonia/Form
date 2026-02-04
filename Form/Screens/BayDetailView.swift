import SwiftUI

struct BayDetailView: View {
    let bay: Bay

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                Text(bay.name)
                    .font(AppTypography.title)
                    .foregroundColor(AppColors.textPrimary)

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    StatRow(label: "Status", value: bay.isOccupied ? "Occupied" : "Available")
                    StatRow(label: "People in bay", value: "\(bay.currentUsers)")
                }
                .padding(AppSpacing.lg)
                .background(AppColors.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: AppRadius.lg)
                        .stroke(AppColors.border, lineWidth: 1)
                )
                .cornerRadius(AppRadius.lg)

                Text("No reservations. Walk up and start.")
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textSecondary)
            }
            .padding(AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle("Bay")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
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

#Preview {
    NavigationStack {
        BayDetailView(bay: SampleData.bays[0])
    }
    .preferredColorScheme(.dark)
}
