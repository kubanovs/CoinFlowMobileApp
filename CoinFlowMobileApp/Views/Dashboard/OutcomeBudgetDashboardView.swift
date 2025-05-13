//
//  NewBudgetDashboardView.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 10.05.2025.
//

import SwiftUI

struct OutcomeBudgetDashBoardView: View {
    
    @EnvironmentObject var outcomeDashboardViewModel : OutcomeDashboardViewModel
    
    @State var showAddCategory = false
    
    @State var showSettings = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.15, green: 0.15, blue: 0.19)
                    .ignoresSafeArea()
                VStack {
                    BudgetDashBoardHeader(headerText: "Expences", showSettings: self.$showSettings)
                    BudgetAnalytic(
                        spendingSum: outcomeDashboardViewModel.getAllSpendings(),
                        balance: outcomeDashboardViewModel.getAllBudget()
                    )
                    .environmentObject(outcomeDashboardViewModel.outcomeGraphicViewModel)
                    OutcomeCategoryCardsList(categories: outcomeDashboardViewModel.allCategories, showAddCategory: $showAddCategory)
                        .padding(.top, 100)
                        .environmentObject(outcomeDashboardViewModel)
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
}

struct BudgetDashBoardHeader: View {
    var headerText : String
    
    @Binding var showSettings : Bool
    
    var body: some View {
        HStack {
            Text(self.headerText)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            Button() {
                self.showSettings = true
            } label: {
                Image(systemName: "gearshape")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(Color.white.opacity(0.7))
            }
            NavigationLink(destination: SettingsView(isActive: self.$showSettings), isActive: self.$showSettings) {
                EmptyView()
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(.gray.opacity(0.3))
                .frame(height : 1)
                .offset(y: 8)
        }
    }
}

struct BudgetAnalytic: View {
    var spendingSum: Double
    var balance: Double

    var body: some View {
        ZStack {
            BudgetGraphic()
            VStack(spacing: 4) {
                Text(String(format: "$%.2f", self.spendingSum))
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                Text(String(format: "of $%.2f", self.balance))
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color.white.opacity(0.5))
            }
            .padding(.top, 100)
        }
        .frame(height: 180)
    }
}

struct BudgetGraphic: View {
    @EnvironmentObject var outcomeGraphicViewModel : OutcomeGraphicViewModel
    var body: some View {
        ZStack {
            let arcShapes = outcomeGraphicViewModel.getArcShapesForOutcomeGraphic()
            ArcShape(startAngle: .degrees(135), endAngle: .degrees(405), clockwise: false)
                .stroke(Color.white.opacity(0.12), style: StrokeStyle(lineWidth: 16, lineCap: .round))
                .frame(width: 220, height: 120)
            ForEach(arcShapes) { arcShape in
                arcShape
                    .stroke(arcShape.color, style: StrokeStyle(lineWidth: 16, lineCap: .round))
                    .frame(width: 220, height: 120)
            }
        }
    }
}

struct OutcomeCategoryCardsList : View {
    var categories : [OutcomeCategory]
    
    @Binding var showAddCategory : Bool
    
    @State var selectedOutcomeCategory : String? = nil
    
    @EnvironmentObject var outcomeDashboardViewModel : OutcomeDashboardViewModel
    
    var body : some View {
        VStack(spacing: 16) {
            List {
                ForEach(categories, id: \.self) { category in
                    BudgetCategoryCard(icon: category.symbolName,
                                       name: category.name,
                                       left: String(format : "$%.2f left to spend", category.limit - category.spendingSum),
                                       total: String(format: "$%.2f", category.limit),
                                       spent: String(format: "$%.2f", category.spendingSum),
                                       progress: category.spendingSum / category.limit,
                                       color: Color(red: category.color.red, green: category.color.green, blue: category.color.blue))
                    .onTapGesture {
                        self.selectedOutcomeCategory = category.name
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    .frame(maxWidth: .infinity)
                }
                .onDelete(perform: deleteCategory)
            }
            .listStyle(PlainListStyle())
            NavigationLink(destination: self.selectedOutcomeCategory.map { OutcomeCategoryDetailView(categoryName: $0, isActive: Binding(get: { self.selectedOutcomeCategory != nil }, set: { if !$0 { self.selectedOutcomeCategory = nil } })).environmentObject(outcomeDashboardViewModel) },
                           isActive: Binding(get: { self.selectedOutcomeCategory != nil }, set: { if !$0 { self.selectedOutcomeCategory = nil } })) { EmptyView() }
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
            .onTapGesture {
                self.showAddCategory = true
            }
            NavigationLink(destination: AddOutcomeCategoryView(isActive: self.$showAddCategory).environmentObject(outcomeDashboardViewModel), isActive: self.$showAddCategory) { EmptyView() }
            Spacer()
        }
        .padding(.horizontal)
        
//        .overlay(alignment: .top) {
//            Rectangle()
//                .fill(.gray.opacity(0.3))
//                .frame(height : 1)
//                .offset(y: -8)
//        }
    }
    
    private func deleteCategory(at offsets: IndexSet) {
        offsets.map { categories[$0] }.forEach { outcomeDashboardViewModel.deleteCategory(category: $0) }
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
    NavigationStack {
        OutcomeBudgetDashBoardView()
    }
}
