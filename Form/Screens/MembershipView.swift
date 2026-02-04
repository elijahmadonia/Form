import SwiftUI

struct MembershipView: View {
    let membership: Membership

    private var renewalText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: membership.renewalDate)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                Text("Membership")
                    .font(AppTypography.title)
                    .foregroundColor(AppColors.textPrimary)

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    StatRow(label: "Plan", value: membership.planName)
                    StatRow(label: "Status", value: membership.status)
                    StatRow(label: "Renews", value: renewalText)
                }
                .padding(AppSpacing.lg)
                .background(AppColors.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: AppRadius.lg)
                        .stroke(AppColors.border, lineWidth: 1)
                )
                .cornerRadius(AppRadius.lg)

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text("Manage")
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.textPrimary)

                    ManageRow(title: "Update payment method")
                    ManageRow(title: "Pause membership")
                    ManageRow(title: "Cancel membership")
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

private struct ManageRow: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(AppTypography.body)
                .foregroundColor(AppColors.textPrimary)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(AppColors.textSecondary)
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
    MembershipView(membership: SampleData.membership)
        .preferredColorScheme(.dark)
}
