//
//  ResetPasswordEmailView.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 12.05.2025.
//

import SwiftUI

struct ResetPasswordEmailView: View {
    
    @State private var emailToReset = ""
    @State private var goToSetToken = false
    
    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.19)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer().frame(height: 40)
                Text("CoinFlow")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 60)
                VStack(alignment: .leading, spacing: 20) {
                    StringField(fieldName: "Email to reset password", fieldLink: self.$emailToReset, isSecret: false)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
                Spacer()
                LongGradientOrangeButton(text: "Reset") {
                    self.goToSetToken = true
                }
                NavigationLink(destination: ResetTokenSetView(), isActive: self.$goToSetToken) { EmptyView() }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ResetPasswordEmailView()
}
