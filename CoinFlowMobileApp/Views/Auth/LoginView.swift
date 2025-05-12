import SwiftUI

struct LoginView: View {
    @State private var login = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var showSignUp = false
    @State private var showDashboard = false
    @State private var showResetPasswordView = false
    @EnvironmentObject var authViewModel: AuthViewModel

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
                    StringField(fieldName: "Login", fieldLink: self.$login, isSecret: false)
                    StringField(fieldName: "Password", fieldLink: self.$password, isSecret: true)
                    HStack {
                        ToggleField(fieldName: "Remember Me", isActive: self.$rememberMe)
                        Spacer()
                        Button(action: {
                            self.showResetPasswordView = true
                        }) {
                            Text("Forgot password")
                                .foregroundColor(Color.white.opacity(0.5))
                                .font(.system(size: 17))
                        }
                        NavigationLink(destination: ResetPasswordEmailView(), isActive: self.$showResetPasswordView) { EmptyView() }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
                Spacer()
                LongGradientOrangeButton(text: "Sign In") {
                    self.authViewModel.isLoggedIn = true
                }

                Text("If you don't have an account yet?")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding(.bottom)
                    .padding(.top)

                LongButton(text: "Sign Up", color: .white.opacity(0.18)) {
                    self.showSignUp = true
                }
                NavigationLink(destination: EmailSignUpView(), isActive: self.$showSignUp) { EmptyView() }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct ToggleField: View {
    var fieldName: String
    @Binding var isActive: Bool

    var body: some View {
        Button(action: { self.isActive.toggle() }) {
            HStack(spacing: 8) {
                Image(systemName: self.isActive ? "checkmark.square.fill" : "square")
                    .foregroundColor(Color.white.opacity(0.5))
                Text(self.fieldName)
                    .foregroundColor(Color.white.opacity(0.5))
                    .font(.system(size: 17))
            }
        }
    }
}

#Preview {
    NavigationView {
        LoginView()
    }
}
