import SwiftUI

struct EmailSignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showLogin = false
    
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
                        Text("E-mail address")
                            .foregroundColor(Color.white.opacity(0.5))
                            .font(.system(size: 15, weight: .medium))
                        TextField("", text: $email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
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
                    // Password strength bar (placeholder, 4 segments)
                    HStack(spacing: 8) {
                        ForEach(0..<4) { _ in
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.white.opacity(0.15))
                                .frame(height: 6)
                        }
                    }
                    .padding(.top, 4)
                    Text("Use 8 or more characters with a mix of letters,\nnumbers & symbols.")
                        .font(.system(size: 16))
                        .foregroundColor(Color.white.opacity(0.32))
                        .padding(.top, 4)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
                // Get started button
                Spacer()
                Button(action: {
                    // Handle sign up
                }) {
                    Text("Get started, it's free!")
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

                VStack(spacing: 20) {
                    Text("Do you have already an account?")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    Button(action: {
                        showLogin = true
                    }) {
                        Text("Sign In")
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
                    NavigationLink(destination: LoginView(), isActive: $showLogin) { EmptyView() }
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
        EmailSignUpView()
    }
} 
