//
//  IncomeBudgetDashboardView.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 10.05.2025.
//

import SwiftUI

struct IncomeBudgetDashboardView: View {
    
    @EnvironmentObject var incomeDashboardViewModel : IncomeDashboardViewModel
    
    @State var showAddIncomeCategory = false
    
    @State var showSettings = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.15, green: 0.15, blue: 0.19)
                    .ignoresSafeArea()
                VStack {
                    BudgetDashBoardHeader(headerText: "Incomes", showSettings: self.$showSettings)
                    IncomeBudgetAnalytic(budget: incomeDashboardViewModel.getAllBudget())
                        .environmentObject(incomeDashboardViewModel.incomeGraphicViewModel)
                    IncomeCategoryCardsList(categories: incomeDashboardViewModel.allCategories, showAddCategory: self.$showAddIncomeCategory)
                        .padding(.top, 100)
                        .environmentObject(incomeDashboardViewModel)
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
}

struct IncomeBudgetAnalytic : View {
    var budget : Double
    var body : some View {
        ZStack {
            IncomeBudgetGraphic()
            VStack(spacing: 4) {
                Text(String(format: "$%.2f", self.budget))
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.top, 100)
        }
        .frame(height: 180)
    }
}

struct IncomeBudgetGraphic: View {
    @EnvironmentObject var incomeGraphicViewModel: IncomeGraphicViewModel
    var body: some View {
        ZStack {
            let arcShapes = incomeGraphicViewModel.getArcShapesForIncomeGraphic()
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

struct IncomeCategoryCardsList : View {
    var categories : [IncomeCategory]
    
    @Binding var showAddCategory : Bool
    
    @State var selectedIncomeCategory : String? = nil
    
    @EnvironmentObject var incomeDashboardViewModel : IncomeDashboardViewModel
    
    var body : some View {
            
        VStack(spacing: 16) {
            List {
                ForEach(categories, id: \.self) { category in
                    IncomeBudgetCategoryCard(icon: category.symbolName,
                                       name: category.name,
                                       total: String(format: "$%.2f", category.income),
                                       progress: 1,
                                       color: Color(red: category.color.red, green: category.color.green, blue: category.color.blue))
                    .onTapGesture {
                        self.selectedIncomeCategory = category.name
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    .frame(maxWidth: .infinity)
                }
                .onDelete(perform: deleteCategory)
            }
            .listStyle(PlainListStyle())
            NavigationLink(destination: self.selectedIncomeCategory.map { IncomeCategoryDetailView(isActive : Binding(get: { self.selectedIncomeCategory != nil }, set: { if !$0 { self.selectedIncomeCategory = nil } }), categoryName: $0).environmentObject(incomeDashboardViewModel) },
                           isActive: Binding(get: { self.selectedIncomeCategory != nil }, set: { if !$0 { self.selectedIncomeCategory = nil } })) { EmptyView() }
            
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
            NavigationLink(destination: AddIncomeCategoryView(isActive: self.$showAddCategory).environmentObject(incomeDashboardViewModel), isActive: self.$showAddCategory) { EmptyView() }
        }
        .padding(.horizontal)
    
    }
    
    private func deleteCategory(at offsets: IndexSet) {
        offsets.map { categories[$0] }.forEach { incomeDashboardViewModel.deleteCategory(category: $0) }
    }
        
}

struct IncomeBudgetCategoryCard: View {
    var icon: String
    var name: String
    var total: String
    var progress: CGFloat
    var color: Color
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
                ProgressView(value: self.progress)
                    .accentColor(self.color)
                    .scaleEffect(x: 1, y: 1.2, anchor: .center)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(self.total)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(24)
    }
}

#Preview {
    NavigationStack {
        IncomeBudgetDashboardView()
    }
}
