import SwiftUI

struct MerchView: View {
    let item: Redeemable

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                Text(item.title)
                    .font(AppTypography.title)
                    .foregroundColor(AppColors.textPrimary)

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    StatRow(label: "Points", value: "\(item.pointsCost)")
                    if let price = item.cashPrice {
                        StatRow(label: "Price", value: price)
                    }
                }
                .padding(AppSpacing.lg)
                .background(AppColors.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: AppRadius.lg)
                        .stroke(AppColors.border, lineWidth: 1)
                )
                .cornerRadius(AppRadius.lg)

                PrimaryButton(title: "Redeem with points") {}
            }
            .padding(AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle("Merch")
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
        MerchView(item: SampleData.redeemables[1])
    }
    .preferredColorScheme(.dark)
}
