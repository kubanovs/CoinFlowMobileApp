import SwiftUI
import AppAuth

struct ContentView: View {
    @State private var authManager = GitHubAuthManager()
    @State private var token: String?
    
    var body: some View {
        VStack {
            if let token = token {
                Text("Logged in with token: \(token)")
            } else {
                Button("Login with GitHub") {
                    authManager.login { receivedToken in
                        DispatchQueue.main.async {
                            token = receivedToken
                        }
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
    }
}

class GitHubAuthManager: NSObject {
    private let clientID = "YOUR_GITHUB_CLIENT_ID"
    private let redirectURI = "yourapp://callback"
    private let authorizationEndpoint = URL(string: "https://github.com/login/oauth/authorize")!
    private let tokenEndpoint = URL(string: "https://github.com/login/oauth/access_token")!
    private var authSession: OIDExternalUserAgentSession?
    
    func login(completion: @escaping (String?) -> Void) {
        let configuration = OIDServiceConfiguration(authorizationEndpoint: authorizationEndpoint, tokenEndpoint: tokenEndpoint)
        let authRequest = OIDAuthorizationRequest(configuration: configuration,
                                                  clientId: clientID,
                                                  scopes: ["user", "repo"],
                                                  redirectURL: URL(string: redirectURI)!,
                                                  responseType: OIDResponseTypeCode,
                                                  additionalParameters: nil)
        
        authSession = OIDAuthState.authState(byPresenting: authRequest) { authState, error in
            if let token = authState?.lastTokenResponse?.accessToken {
                completion(token)
            } else {
                completion(nil)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}f
