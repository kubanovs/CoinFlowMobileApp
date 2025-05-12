//
//  LongGradientOrangeButton.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 09.05.2025.
//

import SwiftUI

struct LongGradientOrangeButton: View {
    private var text: String
    private var buttonAction: () -> Void

    init(text: String, buttonAction: @escaping () -> Void) {
        self.text = text
        self.buttonAction = buttonAction
    }

    var body: some View {
        Button(action: self.buttonAction) {
            Text(self.text)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(red: 1.0, green: 0.6, blue: 0.5), Color(red: 1.0, green: 0.4, blue: 0.3)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(28)
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    LongGradientOrangeButton(text: "text") {
        print(123)
    }
}
