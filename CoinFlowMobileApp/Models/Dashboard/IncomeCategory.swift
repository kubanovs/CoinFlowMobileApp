//
//  IncomeCategory.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 11.05.2025.
//

import Foundation
import SwiftUI

struct IncomeCategory: Codable, Hashable {
    var name: String
    var income : Double
    var symbolName: String = "creditcard"
    var color : RGBColor
    static var mockedData: [IncomeCategory] = [
//        IncomeCategory(
//            name: "Salary",
//            income: 3000.0,
//            symbolName: "dollarsign.circle",
//            color: RGBColor(red: 52, green: 199, blue: 89)
//        ),
//        IncomeCategory(
//            name: "Freelance",
//            income: 800.0,
//            symbolName: "laptopcomputer",
//            color: RGBColor(red: 90, green: 200, blue: 250)
//        ),
//        IncomeCategory(
//            name: "Investments",
//            income: 450.0,
//            symbolName: "chart.line.uptrend.xyaxis",
//            color: RGBColor(red: 255, green: 214, blue: 10)
//        )
    ]
}
