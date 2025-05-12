//
//  IncomeDashboardViewModel.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 11.05.2025.
//

import Foundation
import SwiftUICore

class IncomeDashboardViewModel : ObservableObject {
    @Published var allCategories : [IncomeCategory]
    @Published var allIncomes : [Transaction]
    @Published var incomeGraphicViewModel = IncomeGraphicViewModel()
    
    init() {
        allCategories = IncomeCategory.mockedData
        allIncomes = Transaction.mockedData
            .filter {$0.transactionType == .income}
    }
    
    func getAllBudget() -> Double {
        return allCategories.reduce(0.0) {$0 + $1.income}
    }
    
    func getAllIncomesByCategoryName(categoryName : String) -> [Transaction] {
        return allIncomes
            .filter {$0.categoryName == categoryName}
    }
    
    func addNewCategory(categoryName : String, income : Double) {
        var incomeCategory = IncomeCategory(name: categoryName, income: income, color : RGBColor(
            red: .random(in: 0...255),
            green: .random(in: 0...255),
            blue: .random(in: 0...255)
        ))
        
        allCategories.append(incomeCategory)
        IncomeCategory.mockedData.append(incomeCategory)
        self.incomeGraphicViewModel.objectWillChange.send()
        self.objectWillChange.send()
    }
    
    func deleteCategory(category: IncomeCategory) {
        allCategories.removeAll { $0.name == category.name }
        IncomeCategory.mockedData.removeAll { $0.name == category.name }
        self.incomeGraphicViewModel.objectWillChange.send()
        self.objectWillChange.send()
    }
    
    func addNewIncome(transaction : Transaction) {
        allIncomes.append(transaction)
        Transaction.mockedData.append(transaction)
        incomeGraphicViewModel.objectWillChange.send()
    }
    
    func deleteIncome(transaction : Transaction) {
        allIncomes.removeAll { $0.id == transaction.id}
        Transaction.mockedData.removeAll { $0.id == transaction.id }
        incomeGraphicViewModel.objectWillChange.send()
    }
}
