//
//  SettingView.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 11.05.2025.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isActive : Bool
    @EnvironmentObject var authViewModel : AuthViewModel
    @EnvironmentObject var incomeDashboardViewModel : IncomeDashboardViewModel
    @EnvironmentObject var outcomeDashbaordViewModel : OutcomeDashboardViewModel

    var body: some View {
        ZStack {
            Color(red: 0.13, green: 0.13, blue: 0.17)
                .ignoresSafeArea()
            VStack {
                // Top bar
                HStack {
                    Button(action: {
                        isActive = false
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 28, weight: .medium))
                            .foregroundColor(Color(white: 0.7))
                    }
                    Spacer()
                    Text("Settings")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(Color(white: 0.7))
                    Spacer()
                    // Placeholder for symmetry
                    Spacer().frame(width: 28)
                }
                .padding(.horizontal)
                .padding(.top, 24)

                Spacer().frame(height: 40)
                VStack (alignment: .leading) {
                    HStack {
                        Text(String(authViewModel.username.first!))
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(authViewModel.username)
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                        
                            
                            Text(authViewModel.email)
                                .font(.footnote)
                                .accentColor(.white)
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                
                LongGradientOrangeButton(text: "Log out") {
                    authViewModel.isLoggedIn = false
                    Transaction.mockedData = []
                    incomeDashboardViewModel.allIncomes = []
                    incomeDashboardViewModel.allCategories = []
                    outcomeDashbaordViewModel.allCategories = []
                    outcomeDashbaordViewModel.allSpendings = []
                    OutcomeCategory.mockedData = []
                    IncomeCategory.mockedData = []
                    incomeDashboardViewModel.incomeGraphicViewModel.objectWillChange.send()
                    outcomeDashbaordViewModel.outcomeGraphicViewModel.objectWillChange.send()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    SettingsView()
//}
