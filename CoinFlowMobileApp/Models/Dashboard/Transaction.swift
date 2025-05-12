//
//  Spending.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 10.05.2025.
//

import Foundation

struct Transaction: Hashable, Codable, Identifiable {
    var id : UUID
    var name: String
    var date: Date
    var amount: Double
    var categoryName : String
    var transactionType : TransactionType
    
//    static var mockedData = [
//        Transaction(name: "Washing Car", date: Date.now, amount: 12, categoryName: "Auto", transactionType : .outcome),
//        Transaction(name: "Taxi", date: Date.now, amount: 13, categoryName: "Auto", transactionType : .outcome),
//        Transaction(name: "Movie Ticket", date: Date.now, amount: 15.0, categoryName: "Entertainment", transactionType : .outcome),
//        Transaction(name: "Concert Pass", date: Date.now, amount: 45.0, categoryName: "Entertainment", transactionType : .outcome),
//        Transaction(name: "Home Alarm Subscription", date: Date.now, amount: 8.99, categoryName: "Security", transactionType : .outcome),
//        Transaction(name: "VPN Service", date: Date.now, amount: 4.99, categoryName: "Security", transactionType : .outcome),
//        Transaction(name: "Monthly Salary", date: Date.now, amount: 3000.0, categoryName: "Salary", transactionType: .income),
//        Transaction(name: "Performance Bonus", date: Date.now, amount: 750.0, categoryName: "Salary", transactionType: .income),
//        Transaction(name: "Website Design Project", date: Date.now, amount: 1200.0, categoryName: "Freelance", transactionType: .income),
//        Transaction(name: "Mobile App UI Work", date: Date.now, amount: 850.0, categoryName: "Freelance", transactionType: .income),
//        Transaction(name: "Stock Dividends", date: Date.now, amount: 200.0, categoryName: "Investments", transactionType: .income),
//        Transaction(name: "Crypto Gains", date: Date.now, amount: 500.0, categoryName: "Investments", transactionType: .income),
//    ]
    static var mockedData : [Transaction] = []
    
    
    init(name: String, date: Date, amount: Double, categoryName : String, transactionType : TransactionType) {
        self.id = UUID()
        self.name = name
        self.categoryName = categoryName
        self.date = date
        self.amount = amount
        self.transactionType = transactionType
    }
}

enum TransactionType : String, Codable, CaseIterable, Identifiable {
    case income = "income"
    case outcome = "outcome"
    
    var id : String {self.rawValue}
}
