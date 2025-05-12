//
//  AuthViewModel.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 08.05.2025.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var username = "Savr"
    @Published var email = "svkubanov@edu.hse.ru"
    @Published var isLoggedIn = false
}
