import SwiftUI

struct WelcomeView: View {
    @State private var showSignUp = false
    @State private var showLogin = false
    var body: some View {
        NavigationStack {
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
                        LongGradientOrangeButton(text: "Get started") {
                            self.showSignUp = true
                        }
                        NavigationLink(destination: SignUpView(), isActive: self.$showSignUp) { EmptyView() }
                        LongButton(text: "I have an account", color: .black.opacity(0.7)) {
                            self.showLogin = true
                        }
                        NavigationLink(destination: LoginView(), isActive: self.$showLogin) { EmptyView() }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    NavigationView {
        WelcomeView()
    }
}
