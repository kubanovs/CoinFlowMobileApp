//
//  IncomeGraphicViewModel.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 11.05.2025.
//

import Foundation
import SwiftUI

class IncomeGraphicViewModel: ObservableObject {
    
    func getArcShapesForIncomeGraphic() -> [ArcShape] {
        var incomeCategories = IncomeCategory.mockedData
        
        return convertIncomeCategoriesToArcShapesView(categories: incomeCategories)
    }

    func convertIncomeCategoriesToArcShapesView(categories: [IncomeCategory]) -> [ArcShape] {
        var allBudget = categories.reduce(0.0) {
            $0 + $1.income
        }

        var arcShapes: [ArcShape] = []

        let startDegree = 135.0
        let endDegree = 405.0
        var currentDegree = startDegree

        for (index, category) in categories.enumerated() {
            var currentEndDegree = currentDegree + (category.income / allBudget) * 270
            
            var arcShape = ArcShape(
                startAngle: .degrees(index == 0 ? startDegree : currentDegree),
                endAngle: .degrees(index == categories.count - 1 ? endDegree : currentEndDegree),
                clockwise: false,
                color: Color(red: category.color.red, green: category.color.green, blue: category.color.blue)
            )
            
            currentDegree = currentEndDegree
            
            arcShapes.append(arcShape)
        }

        return arcShapes
    }
}
