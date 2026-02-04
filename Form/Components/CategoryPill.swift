import SwiftUI

struct CategoryPill: View {
    let category: Category
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(category.displayName)
                .font(AppTypography.caption)
                .foregroundColor(isSelected ? .black : AppColors.textPrimary)
                .padding(.horizontal, AppSpacing.md)
                .padding(.vertical, AppSpacing.xs)
                .background(
                    Group {
                        if isSelected {
                            AppColors.accent
                        } else {
                            Color.clear
                        }
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: AppRadius.pill)
                        .stroke(AppColors.border, lineWidth: 1)
                )
                .background(.ultraThinMaterial.opacity(0.9))
                .cornerRadius(AppRadius.pill)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack {
        CategoryPill(category: .mobility, isSelected: true) {}
        CategoryPill(category: .strength, isSelected: false) {}
    }
    .padding()
    .background(AppColors.background)
    .preferredColorScheme(.dark)
}
