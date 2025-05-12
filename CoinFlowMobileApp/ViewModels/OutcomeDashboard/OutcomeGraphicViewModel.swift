//
//  OutcomeGraphicViewModel.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 10.05.2025.
//

import Foundation
import SwiftUI

class OutcomeGraphicViewModel: ObservableObject {
    func getArcShapesForOutcomeGraphic() -> [ArcShape] {
        var outcomeCategories = OutcomeCategory.mockedData
        
        return convertOutcomeCategoriesToArcShapesView(categories: outcomeCategories)
    }

    func convertOutcomeCategoriesToArcShapesView(categories: [OutcomeCategory]) -> [ArcShape] {
        var allBudget = categories.reduce(0.0) {
            $0 + $1.limit
        }
        var allSpengings = categories.reduce(0.0) {
            $0 + $1.spendingSum
        }

        var arcShapes: [ArcShape] = []

        let startDegree = 135.0
        let endDegree =  startDegree + (allSpengings / allBudget) * 270
        var currentDegree = startDegree

        for (index, category) in categories.enumerated() {
            var currentEndDegree = currentDegree + (category.spendingSum / allSpengings) * (endDegree - startDegree)
            
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
