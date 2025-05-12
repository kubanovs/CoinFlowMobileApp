//
//  OutcomeDashboardViewModel.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 10.05.2025.
//

import Foundation
import SwiftUICore

class OutcomeDashboardViewModel : ObservableObject {
    @Published var allCategories : [OutcomeCategory]
    @Published var allSpendings : [Transaction]
    @Published var outcomeGraphicViewModel = OutcomeGraphicViewModel()
    
    init() {
        allCategories = OutcomeCategory.mockedData
        allSpendings = Transaction.mockedData
    }
    
    func getAllSpendings() -> Double {
        return allCategories.reduce(0.0) {$0 + $1.spendingSum}
    }
    
    func getAllBudget() -> Double {
        return allCategories.reduce(0.0) {$0 + $1.limit}
    }
    
    func getAllSpendingsByCategoryName(categoryName : String) -> [Transaction] {
        return allSpendings
            .filter {$0.categoryName == categoryName}
    }
    
    func addNewCategory(categoryName : String, limit : Double) {
        var outcomeCategory = OutcomeCategory(name: categoryName, limit: limit, spendingSum : 0, color : RGBColor(
            red: .random(in: 0...255),
            green: .random(in: 0...255),
            blue: .random(in: 0...255)
        ))
        
        allCategories.append(outcomeCategory)
        OutcomeCategory.mockedData.append(outcomeCategory)
        self.outcomeGraphicViewModel.objectWillChange.send()
        self.objectWillChange.send()
    }
    
    func deleteCategory(category: OutcomeCategory) {
        allCategories.removeAll { $0.name == category.name }
        OutcomeCategory.mockedData.removeAll { $0.name == category.name }
        self.outcomeGraphicViewModel.objectWillChange.send()
        self.objectWillChange.send()
    }
    
    func addNewSpending(transaction : Transaction) {
        allSpendings.append(transaction)
        OutcomeCategory.mockedData = OutcomeCategory.mockedData.map { category in
            if category.name == transaction.categoryName {
                var updated = category
                updated.spendingSum += transaction.amount
                return updated
            } else {
                return category
            }
        }
        allCategories = allCategories.map { category in
            if category.name == transaction.categoryName {
                var updated = category
                updated.spendingSum += transaction.amount
                return updated
            } else {
                return category
            }
        }
        Transaction.mockedData.append(transaction)
        outcomeGraphicViewModel.objectWillChange.send()
        self.objectWillChange.send()
    }
    
    func deleteSpending(transaction: Transaction) {
        allSpendings.removeAll { $0.id == transaction.id }
        OutcomeCategory.mockedData = OutcomeCategory.mockedData.map { category in
            if category.name == transaction.categoryName {
                var updated = category
                updated.spendingSum -= transaction.amount
                return updated
            } else {
                return category
            }
        }
        allCategories = allCategories.map { category in
            if category.name == transaction.categoryName {
                var updated = category
                updated.spendingSum -= transaction.amount
                return updated
            } else {
                return category
            }
        }
        Transaction.mockedData.removeAll { $0.id == transaction.id }

        outcomeGraphicViewModel.objectWillChange.send()
        self.objectWillChange.send()
    }
}
