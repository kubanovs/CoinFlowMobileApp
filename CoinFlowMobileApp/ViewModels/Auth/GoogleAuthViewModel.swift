//
//  GoogleAuthViewModel.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 08.05.2025.
//

import Combine
import Foundation
import OAuth2

class GoogleAuthViewModel {
    static let oauth2 = OAuth2CodeGrant(settings: [
        "client_id": "747902403892-2jkriudjjkli4ddjvqt9flc1tl4uqaqf.apps.googleusercontent.com",
        "authorize_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "scope": "profile",
        "redirect_uris": ["com.googleusercontent.apps.747902403892-2jkriudjjkli4ddjvqt9flc1tl4uqaqf:/oauth"]
    ])

    static func login() {
        GoogleAuthViewModel.oauth2.authorize { authParameters, error in
            if let params = authParameters {
                print("Authorized! Access token is in `oauth2.accessToken`")
                print("Authorized! Additional parameters: \(params)")
                print(GoogleAuthViewModel.oauth2.accessToken!)
                self.oauth2.forgetTokens()
            } else {
                print("Authorization was canceled or went wrong: \(error)") // error will not be nil
            }
        }
    }

    static func processRedirect(url: URL) {
        GoogleAuthViewModel.oauth2.handleRedirectURL(url)

//        let req = oauth2.request(forURL: URL(filePath: "https://www.googleapis.com/oauth2/v1/userinfo?alt=json"))
//        let task = oauth2.session.dataTask(with: req) { data, response, error in
//            if error != nil {
//                // something went wrong, check the error
//            }
//            else {
//                print(response!)
//            }
//        }
//        task.resume()
    }
}
