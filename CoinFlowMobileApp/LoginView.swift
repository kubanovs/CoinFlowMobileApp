import SwiftUI

struct LoginView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var showSignUp = false
    @State private var showDashboard = false
    
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
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Login")
                            .foregroundColor(Color.white.opacity(0.5))
                            .font(.system(size: 15, weight: .medium))
                        TextField("", text: $login)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 24).stroke(Color.white.opacity(0.15), lineWidth: 2))
                            .foregroundColor(.white)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .foregroundColor(Color.white.opacity(0.5))
                            .font(.system(size: 15, weight: .medium))
                        SecureField("", text: $password)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 24).stroke(Color.white.opacity(0.15), lineWidth: 2))
                            .foregroundColor(.white)
                    }
                    HStack {
                        Button(action: { rememberMe.toggle() }) {
                            HStack(spacing: 8) {
                                Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                                    .foregroundColor(Color.white.opacity(0.5))
                                Text("Remember me")
                                    .foregroundColor(Color.white.opacity(0.5))
                                    .font(.system(size: 17))
                            }
                        }
                        Spacer()
                        Button(action: {
                            // Forgot password action
                        }) {
                            Text("Forgot password")
                                .foregroundColor(Color.white.opacity(0.5))
                                .font(.system(size: 17))
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
                Spacer()
                Button(action: {
                    // Mock login success
                    showDashboard = true
                }) {
                    Text("Sign In")
                        .font(.system(size: 20, weight: .semibold))
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
                        .cornerRadius(40)
                        .shadow(color: Color(red: 1.0, green: 0.4, blue: 0.3).opacity(0.5), radius: 24, x: 0, y: 8)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 20)
                NavigationLink(destination: BudgetDashboardView(), isActive: $showDashboard) { EmptyView() }
                VStack(spacing: 20) {
                    Text("If you don't have an account yet?")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    Button(action: {
                        showSignUp = true
                    }) {
                        Text("Sign Up")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.08))
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.white.opacity(0.18), lineWidth: 1)
                            )
                            .cornerRadius(40)
                    }
                    NavigationLink(destination: EmailSignUpView(), isActive: $showSignUp) { EmptyView() }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationView {
        LoginView()
    }
} 