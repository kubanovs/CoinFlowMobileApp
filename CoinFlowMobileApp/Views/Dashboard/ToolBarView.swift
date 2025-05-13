//
//  ToolBarView.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 10.05.2025.
//

import SwiftUI

struct ToolBarView: View {
    
    @StateObject var incomeDashboardViewModel = IncomeDashboardViewModel()
    @StateObject var outcomeDashboardViewModel = OutcomeDashboardViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
    
            OutcomeBudgetDashBoardView()
            .tabItem() {
                Label("Outcomes", systemImage: "creditcard")
            }
            .environmentObject(outcomeDashboardViewModel)
            .environmentObject(incomeDashboardViewModel)
            .tag(0)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        authViewModel.isLoggedIn = false
                    }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.white)
                    }
                }
            }
            
            IncomeBudgetDashboardView()
            .tabItem() {
                Label("Incomes", systemImage: "chart.line.uptrend.xyaxis")
            }
            .environmentObject(incomeDashboardViewModel)
            .environmentObject(outcomeDashboardViewModel)
            .tag(1)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        authViewModel.isLoggedIn = false
                    }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.white)
                    }
                }
            }
            
            AddTransactionView(selectedTab: $selectedTab)
                .tabItem() {
                    Label("Add Transaction", systemImage: "plus.circle")
                }
                .environmentObject(incomeDashboardViewModel)
                .environmentObject(outcomeDashboardViewModel)
                .tag(2)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            authViewModel.isLoggedIn = false
                        }) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.white)
                        }
                    }
                }

            .toolbarBackground(Color(red: 0.15, green: 0.15, blue: 0.19).opacity(0.1), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    ToolBarView()
}
