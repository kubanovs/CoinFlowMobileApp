import Foundation
import SwiftUICore

struct OutcomeCategory: Codable, Hashable {
    var name: String
    var limit: Double
    var spendingSum: Double
    var symbolName: String = "creditcard"
    var color : RGBColor
    static var mockedData: [OutcomeCategory] = [
//        OutcomeCategory(
//            name: "Auto",
//            limit: 100,
//            spendingSum: Transaction
//                .mockedData
//                .filter { $0.categoryName == "Auto"}
//                .map { $0.amount }
//                .reduce(0.0, +),
//            symbolName: "car",
//            color: RGBColor(red: 0, green: 122, blue: 255)),
//        OutcomeCategory(
//            name: "Entertainment",
//            limit: 200,
//            spendingSum: Transaction
//                .mockedData
//                .filter { $0.categoryName == "Entertainment"}
//                .map { $0.amount }
//                .reduce(0.0, +),
//            symbolName: "sparkles",
//            color: RGBColor(red: 255, green: 149, blue: 0)),
//        OutcomeCategory(
//            name: "Security",
//            limit: 100,
//            spendingSum: Transaction
//                .mockedData
//                .filter { $0.categoryName == "Security"}
//                .map { $0.amount }
//                .reduce(0.0, +) ,
//            symbolName: "touchid",
//            color : RGBColor(red: 175, green: 82, blue: 222))
    ]
}
