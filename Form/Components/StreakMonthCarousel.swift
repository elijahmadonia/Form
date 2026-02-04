import SwiftUI

struct StreakMonthCarousel: View {
    let months: [Date]
    let activeDaysProvider: (Date) -> Set<Int>

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                ForEach(months, id: \.self) { monthDate in
                    StreakMonthCard(
                        monthDate: monthDate,
                        activeDays: activeDaysProvider(monthDate)
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct StreakMonthCard: View {
    let monthDate: Date
    let activeDays: Set<Int>

    private var monthTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: monthDate)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text(monthTitle)
                .font(AppTypography.headline)
                .foregroundColor(AppColors.textPrimary)

            Rectangle()
                .fill(AppColors.border)
                .frame(height: 1)

            StreakWeekdayRow(style: .regular)

            StreakMonthGrid(monthDate: monthDate, activeDays: activeDays)
        }
        .padding(AppSpacing.lg)
        .background(AppColors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.lg)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .cornerRadius(AppRadius.lg)
        .shadow(color: AppColors.cardShadow, radius: 16, x: 0, y: 12)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct StreakWeekdayRow: View {
    let style: StreakMonthGrid.Style
    private let calendar = Calendar.current

    init(style: StreakMonthGrid.Style = .regular) {
        self.style = style
    }

    private var weekdaySymbols: [String] {
        let symbols = calendar.shortStandaloneWeekdaySymbols
        let first = calendar.firstWeekday - 1
        return Array(symbols[first...] + symbols[..<first])
    }

    private var columns: [GridItem] {
        Array(repeating: GridItem(.fixed(style.cellSize), spacing: style.gridSpacing), count: 7)
    }

    var body: some View {
        LazyVGrid(columns: columns, spacing: style.weekdaySpacing) {
            ForEach(weekdaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .font(style.weekdayFont)
                    .foregroundColor(AppColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

struct StreakMonthGrid: View {
    enum Style {
        case regular
        case compact

        var cellSize: CGFloat {
            switch self {
            case .regular: return 36
            case .compact: return 28
            }
        }

        var gridSpacing: CGFloat {
            switch self {
            case .regular: return 8
            case .compact: return 6
            }
        }

        var weekdaySpacing: CGFloat {
            switch self {
            case .regular: return 6
            case .compact: return 4
            }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .regular: return 12
            case .compact: return 10
            }
        }

        var glossHeight: CGFloat {
            switch self {
            case .regular: return 6
            case .compact: return 4
            }
        }

        var glossWidthRatio: CGFloat {
            switch self {
            case .regular: return 0.6
            case .compact: return 0.55
            }
        }

        var shadowRadius: CGFloat {
            switch self {
            case .regular: return 10
            case .compact: return 8
            }
        }

        var shadowOffsetY: CGFloat {
            switch self {
            case .regular: return 6
            case .compact: return 4
            }
        }

        var dayFont: Font {
            switch self {
            case .regular:
                return AppTypography.caption
            case .compact:
                return .system(size: 10, weight: .medium, design: .rounded)
            }
        }

        var weekdayFont: Font {
            switch self {
            case .regular:
                return AppTypography.caption
            case .compact:
                return .system(size: 10, weight: .semibold, design: .rounded)
            }
        }

        var dayTextSpacing: CGFloat {
            switch self {
            case .regular: return 6
            case .compact: return 4
            }
        }
    }

    let monthDate: Date
    let activeDays: Set<Int>
    let style: Style

    init(monthDate: Date, activeDays: Set<Int>, style: Style = .regular) {
        self.monthDate = monthDate
        self.activeDays = activeDays
        self.style = style
    }

    private let calendar = Calendar.current

    private var daysInMonth: Int {
        calendar.range(of: .day, in: .month, for: monthDate)?.count ?? 30
    }

    private var firstWeekdayOffset: Int {
        let comps = calendar.dateComponents([.year, .month], from: monthDate)
        let firstDay = calendar.date(from: comps) ?? monthDate
        let weekday = calendar.component(.weekday, from: firstDay)
        let first = calendar.firstWeekday
        return (weekday - first + 7) % 7
    }

    private var rowsToShow: Int {
        let totalCells = firstWeekdayOffset + daysInMonth
        return Int(ceil(Double(totalCells) / 7.0))
    }

    private var columns: [GridItem] {
        Array(repeating: GridItem(.fixed(style.cellSize), spacing: style.gridSpacing), count: 7)
    }

    var body: some View {
        LazyVGrid(columns: columns, spacing: style.gridSpacing) {
            ForEach(0..<(rowsToShow * 7), id: \.self) { index in
                let day = index - firstWeekdayOffset + 1
                if day < 1 || day > daysInMonth {
                    StreakDayCell(day: nil, style: .empty, layout: style)
                } else if activeDays.contains(day) {
                    StreakDayCell(day: day, style: .active, layout: style)
                } else {
                    StreakDayCell(day: day, style: .inactive, layout: style)
                }
            }
        }
    }
}

struct StreakDayCell: View {
    enum Style {
        case empty
        case inactive
        case active
    }

    let day: Int?
    let style: Style
    let layout: StreakMonthGrid.Style
    let showsDayNumber: Bool

    init(day: Int?, style: Style, layout: StreakMonthGrid.Style = .regular, showsDayNumber: Bool = true) {
        self.day = day
        self.style = style
        self.layout = layout
        self.showsDayNumber = showsDayNumber
    }

    var body: some View {
        VStack(spacing: layout.dayTextSpacing) {
            pill

            if showsDayNumber {
                if let day {
                    Text("\(day)")
                        .font(layout.dayFont)
                        .foregroundColor(AppColors.textSecondary)
                } else {
                    Text(" ")
                        .font(layout.dayFont)
                        .foregroundColor(.clear)
                }
            }
        }
    }

    @ViewBuilder
    private var pill: some View {
        switch style {
        case .empty:
            RoundedRectangle(cornerRadius: layout.cornerRadius, style: .continuous)
                .fill(Color.clear)
                .frame(width: layout.cellSize, height: layout.cellSize)
        case .inactive:
            RoundedRectangle(cornerRadius: layout.cornerRadius, style: .continuous)
                .fill(AppColors.background)
                .frame(width: layout.cellSize, height: layout.cellSize)
                .overlay(
                    RoundedRectangle(cornerRadius: layout.cornerRadius, style: .continuous)
                        .stroke(AppColors.border, lineWidth: 1)
                )
        case .active:
            RoundedRectangle(cornerRadius: layout.cornerRadius, style: .continuous)
                .fill(AppColors.accent)
                .frame(width: layout.cellSize, height: layout.cellSize)
                .overlay(
                    RoundedRectangle(cornerRadius: layout.cornerRadius, style: .continuous)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.system(size: layout.cellSize * 0.45, weight: .bold))
                        .foregroundColor(.white)
                )
        }
    }
}

struct StreakWeekPreview: View {
    let referenceDate: Date
    let activeDays: Set<Int>

    init(referenceDate: Date = Date(), activeDays: Set<Int>) {
        self.referenceDate = referenceDate
        self.activeDays = activeDays
    }

    private let calendar = Calendar.current

    private var lastSevenDays: [Date] {
        (0..<7).compactMap { offset in
            calendar.date(byAdding: .day, value: -offset, to: referenceDate)
        }
        .reversed()
    }

    private var weekdaySymbols: [String] {
        calendar.shortStandaloneWeekdaySymbols
    }

    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: StreakMonthGrid.Style.compact.gridSpacing), count: 7)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            LazyVGrid(columns: columns, spacing: StreakMonthGrid.Style.compact.gridSpacing) {
                ForEach(lastSevenDays, id: \.self) { date in
                    let day = calendar.component(.day, from: date)
                    let monthMatches = calendar.isDate(date, equalTo: referenceDate, toGranularity: .month)
                    let isActive = monthMatches && activeDays.contains(day)
                    StreakDayCell(
                        day: day,
                        style: isActive ? .active : .inactive,
                        layout: .compact,
                        showsDayNumber: false
                    )
                }
            }

            LazyVGrid(columns: columns, spacing: StreakMonthGrid.Style.compact.weekdaySpacing) {
                ForEach(lastSevenDays, id: \.self) { date in
                    let weekday = calendar.component(.weekday, from: date)
                    let index = weekday - 1
                    let symbol = (weekdaySymbols.indices.contains(index) ? weekdaySymbols[index] : "")
                    Text(symbol)
                        .font(StreakMonthGrid.Style.compact.weekdayFont)
                        .foregroundColor(AppColors.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
    }
}

#Preview {
    let calendar = Calendar.current
    let months = (0...8).compactMap { calendar.date(byAdding: .month, value: -$0, to: Date()) }

    ZStack {
        AppColors.background
        VStack(spacing: AppSpacing.xl) {
            StreakMonthCarousel(months: months) { _ in
                [1, 2, 3, 5, 6, 8, 9, 16, 19, 24, 25, 26, 29]
            }

            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                StreakWeekPreview(activeDays: [2, 4, 9, 13, 19, 22, 27])
            }
            .padding(AppSpacing.lg)
            .background(AppColors.surface)
            .cornerRadius(AppRadius.lg)
        }
    }
    .preferredColorScheme(.dark)
}
