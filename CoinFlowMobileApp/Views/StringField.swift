//
//  AuthField.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 09.05.2025.
//

import SwiftUI

struct StringField: View {
    var fieldName: String
    @Binding var fieldLink: String
    var isSecret: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(self.fieldName)
                .foregroundColor(Color.white.opacity(0.5))
                .font(.system(size: 15, weight: .medium))

            if self.isSecret {
                SecureField("", text: self.$fieldLink)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 24).stroke(Color.white.opacity(0.15), lineWidth: 2))
                    .foregroundColor(.white)
            } else {
                TextField("", text: self.$fieldLink)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 24).stroke(Color.white.opacity(0.15), lineWidth: 2))
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    @Previewable @State var link = String()
    ZStack {
        Color(red: 0.15, green: 0.15, blue: 0.19)
            .ignoresSafeArea()
        StringField(fieldName: "Test", fieldLink: $link, isSecret: true)
    }
}
