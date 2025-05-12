import SwiftUI

struct EmailSignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var showLogin = false
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
                    StringField(fieldName: "Username", fieldLink: self.$username, isSecret: false)
                    StringField(fieldName: "Email", fieldLink: self.$email, isSecret: false)
                    StringField(fieldName: "Password", fieldLink: self.$password, isSecret: true)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
                // Get started button
                Spacer()
                LongGradientOrangeButton(text: "Get started, it's free!") {
                    authViewModel.email = self.email
                    authViewModel.username = self.username
                    authViewModel.isLoggedIn = true
                }
                    .padding(.bottom)
                Text("Do you have already an account?")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                LongButton(text: "Sing In", color: .gray.opacity(0.1)) {
                    self.showLogin = true
                }
                .padding(.top)
                NavigationLink(destination: LoginView(), isActive: self.$showLogin) { EmptyView() }
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
