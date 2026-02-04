import SwiftUI

struct ShopView: View {
    private let points = SampleData.points
    private let redeemables = SampleData.redeemables

    private var merch: [Redeemable] {
        redeemables.filter { $0.type == .merch }
    }

    private var milkshakes: [Redeemable] {
        redeemables.filter { $0.type == .milkshake }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    HStack {
                        Text("Shop")
                            .font(AppTypography.title)
                            .foregroundColor(AppColors.textPrimary)

                        Spacer()

                        PointsBadge(points: points.balance)
                    }

                    ShopGrid(items: redeemables, points: points)
                }
                .padding(AppSpacing.lg)
            }
            .background(AppColors.background)
        }
    }
}

private struct PointsBadge: View {
    let points: Int

    var body: some View {
        HStack(spacing: AppSpacing.xs) {
            Image(systemName: "sparkles")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(AppColors.accent)
            Text("\(points)")
                .font(AppTypography.caption)
                .foregroundColor(AppColors.textPrimary)
        }
        .padding(.horizontal, AppSpacing.sm)
        .padding(.vertical, 6)
        .background(AppColors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.pill)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .cornerRadius(AppRadius.pill)
    }
}

private struct ShopGrid: View {
    let items: [Redeemable]
    let points: PointsAccount

    private let columns = [
        GridItem(.flexible(), spacing: AppSpacing.md),
        GridItem(.flexible(), spacing: AppSpacing.md)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: AppSpacing.md) {
            ForEach(items) { item in
                NavigationLink {
                    if item.type == .milkshake {
                        MilkshakeOrderView(item: item, points: points)
                    } else {
                        MerchView(item: item)
                    }
                } label: {
                    SquareTile(
                        title: item.title,
                        subtitle: "\(item.pointsCost) points\(item.cashPrice.map { " • \($0)" } ?? "")",
                        systemImageName: item.type == .milkshake ? "cup.and.saucer.fill" : "tshirt.fill",
                        imageName: nil
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    ShopView()
        .preferredColorScheme(.dark)
}
