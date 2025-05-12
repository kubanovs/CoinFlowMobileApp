//
//  NewBudgetDashboardView.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 10.05.2025.
//

import SwiftUI

struct NewBudgetDashBoardView: View {
    
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
                    CategoryCardsList(categories: outcomeDashboardViewModel.allCategories, showAddCategory: $showAddCategory)
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

struct CategoryCardsList : View {
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
            NavigationLink(destination: self.selectedOutcomeCategory.map { CategoryDetailView(categoryName: $0, isActive: Binding(get: { self.selectedOutcomeCategory != nil }, set: { if !$0 { self.selectedOutcomeCategory = nil } })).environmentObject(outcomeDashboardViewModel) },
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
            NavigationLink(destination: AddCategoryView(isActive: self.$showAddCategory).environmentObject(outcomeDashboardViewModel), isActive: self.$showAddCategory) { EmptyView() }
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

#Preview {
    NavigationStack {
        NewBudgetDashBoardView()
    }
}
