//
//  RGBColor.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 10.05.2025.
//

struct RGBColor : Codable, Hashable{
    var red: Double   // 0.0 - 1.0
    var green: Double // 0.0 - 1.0
    var blue: Double  // 0.0 - 1.0
    
    init(red: Int, green: Int, blue: Int) {
        self.red = Double(red) / 255.0
        self.green = Double(green) / 255.0
        self.blue = Double(blue) / 255.0
    }
}
