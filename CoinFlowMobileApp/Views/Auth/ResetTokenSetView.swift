//
//  SwiftUIView.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 12.05.2025.
//

import SwiftUI

struct ResetTokenSetView: View {
    
    @State private var token = ""
    @EnvironmentObject private var authViewModel : AuthViewModel
    
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
                    StringField(fieldName: "Reset Token", fieldLink: self.$token, isSecret: false)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
                Spacer()
                LongGradientOrangeButton(text: "Reset") {
                    authViewModel.isLoggedIn = true
                }
//                NavigationLink(destination: EmailSignUpView(), isActive: self.$showSignUp) { EmptyView() }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ResetTokenSetView()
}
