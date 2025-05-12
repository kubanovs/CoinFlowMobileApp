//
//  SignUpView.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 03.05.2025.
//

import SwiftUI

struct SignUpView: View {
    @State private var showEmailSignUp = false
    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.19)
                .ignoresSafeArea()
            VStack {
                Text("CoinFlow")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 40)
                Spacer()
                VStack(spacing: 24) {
                    Button(action: {
                        // GitHub sign up action
                    }) {
                        Button {
                            GoogleAuthViewModel.login()
                        } label: {
                            HStack {
                                Image("logo.google")
                                    .resizable()
                                    .frame(width: 40, height: 30)
                                    .font(.system(size: 22, weight: .bold))
                                Text("Sign up with Google")
                                    .font(.system(size: 20, weight: .semibold))
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(40)
                            .shadow(color: Color.black.opacity(0.25), radius: 16, x: 0, y: 8)
                        }
                    }
                    Text("or")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    Button(action: {
                        self.showEmailSignUp = true
                    }) {
                        Text("Sign up with E-mail")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color.white.opacity(0.08))
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.white.opacity(0.18), lineWidth: 1)
                            )
                            .cornerRadius(40)
                    }
                    NavigationLink(destination: EmailSignUpView(), isActive: self.$showEmailSignUp) { EmptyView() }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
                Text("By registering, you agree to our Terms of Use. Learn how we collect, use and share your data.")
                    .font(.system(size: 16))
                    .foregroundColor(Color.white.opacity(0.32))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignUpView()
}
