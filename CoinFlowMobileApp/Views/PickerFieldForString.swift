//
//  SwiftUIView.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 11.05.2025.
//

import SwiftUI

struct PickerFieldForString: View {
    var name : String
    @Binding var selection : String
    var choices : [String]
    @EnvironmentObject var outcomeDashboardViewModel : OutcomeDashboardViewModel
    @EnvironmentObject var incomeDashboardViewModel : IncomeDashboardViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name)
                .foregroundColor(Color.white.opacity(0.5))
                .font(.system(size: 18, weight: .medium))
            Picker("Select category", selection: self.$selection) {
                ForEach(choices, id: \.self) { el in
                    Text(el).tag(el)
                }
            }
            .accentColor(.white)
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(RoundedRectangle(cornerRadius: 18).stroke(Color.white.opacity(0.15), lineWidth: 2))
        }
    }
}

struct TestViewWrapperString : View {
    @State private var selection = "first"
    @State private var choices = ["first", "second", "third"]
    
    var body : some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.19)
                .ignoresSafeArea()
            PickerFieldForString(name: "testPicker", selection: self.$selection, choices: choices)
        }
    }
}

#Preview {
    TestViewWrapperString()
}
