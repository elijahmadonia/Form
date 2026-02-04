import SwiftUI

struct MilkshakeOrderView: View {
    let item: Redeemable
    let points: PointsAccount

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                Text("Order")
                    .font(AppTypography.title)
                    .foregroundColor(AppColors.textPrimary)

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text(item.title)
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.textPrimary)

                    Text("Redeem for \(item.pointsCost) points")
                        .font(AppTypography.body)
                        .foregroundColor(AppColors.textSecondary)

                    Text("Balance: \(points.balance) points")
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

                PrimaryButton(title: "Place order") {}
            }
            .padding(AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle("Milkshake")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

#Preview {
    NavigationStack {
        MilkshakeOrderView(item: SampleData.redeemables[0], points: SampleData.points)
    }
    .preferredColorScheme(.dark)
}
