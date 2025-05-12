import SwiftUI

struct BudgetDashboardView: View {
    @State private var selectedTab: BudgetTab = .outcome
    @State private var showAddCategory = false
    @State private var showAddIncomeCategory = false
    @State private var selectedCategory: String? = nil
    @State private var selectedIncomeCategory: String? = nil
    @State private var showAddSpending = false
    @State private var showAddIncome = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.15, green: 0.15, blue: 0.19)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Spacer()
                        Image(systemName: "gearshape")
                            .font(.system(size: 28, weight: .medium))
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    // Arc progress
                    ZStack {
                        ArcProgressView(tab: self.selectedTab)
                        VStack(spacing: 4) {
                            Text(self.selectedTab == .outcome ? "$82,97" : "$1,200")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                            if self.selectedTab == .outcome {
                                Text("of $2,000 budget")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(Color.white.opacity(0.5))
                            }
                        }
                        .padding(.top, 100)
                    }
                    .frame(height: 180)
                    Spacer()
                    // Category cards
                    VStack(spacing: 16) {
                        if self.selectedTab == .outcome {
                            BudgetCategoryCard(icon: "car", name: "Auto & Transport", left: "$375 left to spend", total: "$400", spent: "$25.99", progress: 0.06, color: Color.cyan)
                                .onTapGesture { self.selectedCategory = "Auto & Transport" }
                            BudgetCategoryCard(icon: "sparkles", name: "Entertainment", left: "$375 left to spend", total: "$600", spent: "$50.99", progress: 0.085, color: Color.orange)
                                .onTapGesture { self.selectedCategory = "Entertainment" }
                            BudgetCategoryCard(icon: "touchid", name: "Security", left: "$375 left to spend", total: "$600", spent: "$5.99", progress: 0.01, color: Color.purple)
                                .onTapGesture { self.selectedCategory = "Security" }
                        } else {
                            BudgetCategoryCard(icon: "creditcard", name: "Salary", left: nil, total: "$1,200", spent: "$200.00", progress: 0.83, color: Color.green, showIncome: true)
                                .onTapGesture { self.selectedIncomeCategory = "Salary" }
                            BudgetCategoryCard(icon: "gift", name: "Gift", left: nil, total: "$300", spent: "$100.00", progress: 0.67, color: Color.blue, showIncome: true)
                                .onTapGesture { self.selectedIncomeCategory = "Gift" }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, self.selectedTab == .outcome ? 64 : 32)
//                    NavigationLink(destination: self.selectedCategory.map { CategoryDetailView(categoryName: $0) }, isActive: Binding(get: { self.selectedCategory != nil }, set: { if !$0 { self.selectedCategory = nil } })) { EmptyView() }
////                    NavigationLink(destination: self.selectedIncomeCategory.map { IncomeCategoryDetailView(categoryName: $0) }, isActive: Binding(get: { self.selectedIncomeCategory != nil }, set: { if !$0 { self.selectedIncomeCategory = nil } })) { EmptyView() }
                    // Add new category
                    HStack {
                        Spacer()
                        Text("Add new category")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color.white.opacity(0.7))
                        Image(systemName: "plus.circle")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(Color.white.opacity(0.7))
                        Spacer()
                    }
                    .frame(height: 64)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [6]))
                            .foregroundColor(Color.white.opacity(0.18))
                    )
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .onTapGesture {
                        if self.selectedTab == .outcome {
                            self.showAddCategory = true
                        } else {
                            self.showAddIncomeCategory = true
                        }
                    }
//                    NavigationLink(destination: AddIncomeCategoryView(), isActive: self.$showAddIncomeCategory) { EmptyView() }
                    Spacer()
                    // Tab bar
                    BudgetTabBar(onPlusTapped: {
                        if self.selectedTab == .outcome {
                            self.showAddSpending = true
                        } else {
                            self.showAddIncome = true
                        }
                    })
//                    NavigationLink(destination: AddTransactionView(), isActive: self.$showAddSpending) { EmptyView() }
//                    NavigationLink(destination: AddIncomeView(), isActive: self.$showAddIncome) { EmptyView() }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

enum BudgetTab: String, CaseIterable {
    case income = "Income"
    case outcome = "Outcome"
}

struct BudgetSegmentedControl: View {
    @Binding var selectedTab: BudgetTab

    var body: some View {
        HStack(spacing: 10) {
            ForEach(BudgetTab.allCases, id: \.self) { tab in
                self.segmentButton(for: tab)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.black.opacity(0.7))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
        .offset(x: 69)
    }

    @ViewBuilder
    private func segmentButton(for tab: BudgetTab) -> some View {
        Button(action: { self.selectedTab = tab }) {
            Text(tab.rawValue)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(self.selectedTab == tab ? .white : Color.white.opacity(0.6))
                .frame(width: 110, height: 44)
                .background(self.selectedBackground(for: tab))
        }
    }

    private func selectedBackground(for tab: BudgetTab) -> some View {
        RoundedRectangle(cornerRadius: 22)
            .fill(Color.white.opacity(0.08))
            .shadow(
                color: Color(red: 1.0, green: 0.4, blue: 0.3)
                    .opacity(self.selectedTab == .outcome && tab == .outcome ? 0.25 : 0),
                radius: 8, x: 0, y: 4
            )
    }
}

struct ArcProgressView: View {
    var tab: BudgetTab = .outcome
    var body: some View {
        ZStack {
            ArcShape(startAngle: .degrees(135), endAngle: .degrees(405), clockwise: false)
                .stroke(Color.white.opacity(0.12), style: StrokeStyle(lineWidth: 16, lineCap: .round))
                .frame(width: 220, height: 120)
            if self.tab == .outcome {
                ArcShape(startAngle: .degrees(135), endAngle: .degrees(195), clockwise: false)
                    .stroke(Color.cyan, style: StrokeStyle(lineWidth: 16, lineCap: .round))
                    .frame(width: 220, height: 120)
                ArcShape(startAngle: .degrees(195), endAngle: .degrees(270), clockwise: false)
                    .stroke(Color.orange, style: StrokeStyle(lineWidth: 16, lineCap: .round))
                    .frame(width: 220, height: 120)
                ArcShape(startAngle: .degrees(270), endAngle: .degrees(345), clockwise: false)
                    .stroke(Color.purple, style: StrokeStyle(lineWidth: 16, lineCap: .round))
                    .frame(width: 220, height: 120)
            } else {
                ArcShape(startAngle: .degrees(135), endAngle: .degrees(270), clockwise: false)
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 16, lineCap: .round))
                    .frame(width: 220, height: 120)
                ArcShape(startAngle: .degrees(270), endAngle: .degrees(405), clockwise: false)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 16, lineCap: .round))
                    .frame(width: 220, height: 120)
            }
        }
    }
}

struct ArcShape: Shape, Identifiable {
    var id = UUID()
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var color: Color = .white
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.maxY),
            radius: rect.width / 2,
            startAngle: self.startAngle,
            endAngle: self.endAngle,
            clockwise: self.clockwise
        )
        return path
    }
}

struct BudgetCategoryCard: View {
    var icon: String
    var name: String
    var left: String?
    var total: String
    var spent: String
    var progress: CGFloat
    var color: Color
    var showIncome = false
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: self.icon)
                .font(.system(size: 25))
                .foregroundColor(self.color)
                .frame(width: 44)
                .padding(7)
            VStack(alignment: .leading, spacing: 4) {
                Text(self.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                if let left, !showIncome {
                    Text(left)
                        .font(.system(size: 15))
                        .foregroundColor(Color.white.opacity(0.5))
                }
                ProgressView(value: self.progress)
                    .accentColor(self.color)
                    .scaleEffect(x: 1, y: 1.2, anchor: .center)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(self.spent)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                if !self.showIncome {
                    Text("of \(self.total)")
                        .font(.system(size: 16))
                        .foregroundColor(Color.white.opacity(0.5))
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(24)
    }
}

struct BudgetTabBar: View {
    var onPlusTapped: (() -> Void)? = nil
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "house")
                .font(.system(size: 28))
                .foregroundColor(Color.white.opacity(0.7))
            Spacer()
            Image(systemName: "square.grid.2x2")
                .font(.system(size: 28))
                .foregroundColor(Color.white.opacity(0.7))
            Spacer()
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(red: 1.0, green: 0.6, blue: 0.5), Color(red: 1.0, green: 0.4, blue: 0.3)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 64, height: 64)
                    .shadow(color: Color(red: 1.0, green: 0.4, blue: 0.3).opacity(0.5), radius: 16, x: 0, y: 8)
                Image(systemName: "plus")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
            }
            .onTapGesture {
                self.onPlusTapped?()
            }
            Spacer()
            Image(systemName: "calendar")
                .font(.system(size: 28))
                .foregroundColor(Color.white.opacity(0.7))
            Spacer()
            Image(systemName: "briefcase")
                .font(.system(size: 28))
                .foregroundColor(Color.white.opacity(0.7))
            Spacer()
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
        .background(Color.white.opacity(0.04))
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .padding(.horizontal, 8)
    }
}

#Preview {
    BudgetDashboardView()
}
