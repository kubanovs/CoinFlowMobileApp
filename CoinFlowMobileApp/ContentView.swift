import AppAuth
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        Group {
            if self.authViewModel.isLoggedIn {
                ToolBarView()
            } else {
                WelcomeView()
                    .onOpenURL { url in
                        GoogleAuthViewModel.processRedirect(url: url)
                        self.authViewModel.username = "kubanov.sawr"
                        self.authViewModel.email = "kubanov.sawr@gmail.com"
                        self.authViewModel.isLoggedIn = true
                    }
            }
        }
        .transition(.opacity)
        .animation(.easeInOut, value: self.authViewModel.isLoggedIn)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
