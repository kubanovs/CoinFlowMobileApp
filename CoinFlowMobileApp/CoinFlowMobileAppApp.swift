//
//  CoinFlowMobileAppApp.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 02.02.2025.
//

import OAuth2
import SwiftUI
import UIKit

@main
struct CoinFlowMobileAppApp: App {
    @StateObject var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.authViewModel)
        }
    }
}
