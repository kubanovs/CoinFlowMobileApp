//
//  LongButton.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 09.05.2025.
//

import SwiftUI

struct LongButton: View {
    private var text: String
    private var color: Color
    private var buttonAction: () -> Void

    init(text: String, color: Color, buttonAction: @escaping () -> Void) {
        self.text = text
        self.color = color
        self.buttonAction = buttonAction
    }

    var body: some View {
        Button(action: self.buttonAction) {
            Text(self.text)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(self.color)
                .cornerRadius(28)
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    LongButton(text: "text", color: .black.opacity(0.7)) {
        print(123)
    }
}
