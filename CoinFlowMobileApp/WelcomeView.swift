import SwiftUI

struct WelcomeView: View {
    @State private var showSignUp = false
    @State private var showLogin = false
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack(spacing: 32) {
                    Spacer()
                    Text("CoinFlow")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    Image("money")
                        .resizable()
                        .frame(width: 180, height: 180)
                        .shadow(radius: 20)
                        .padding(.vertical, 16)
                    Text("Welcome to CoinFlow App for your finance")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    Spacer()
                    VStack(spacing: 16) {
                        Button(action: {
                            showSignUp = true
                        }) {
                            Text("Get started")
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
                        NavigationLink(destination: SignUpView(), isActive: $showSignUp) { EmptyView() }
                        Button(action: {
                            showLogin = true
                        }) {
                            Text("I have an account")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(28)
                                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                        }
                        NavigationLink(destination: LoginView(), isActive: $showLogin) { EmptyView() }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
} 
