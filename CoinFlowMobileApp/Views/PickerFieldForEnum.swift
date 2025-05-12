//
//  PickerField.swift
//  CoinFlowMobileApp
//
//  Created by Savr Kubanov on 11.05.2025.
//

import SwiftUI

struct PickerFieldForEnum<T>: View where T: Hashable & Identifiable & CaseIterable, T.AllCases: RandomAccessCollection {
    
    var name : String
    @Binding var selection : T
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name)
                .foregroundColor(Color.white.opacity(0.5))
                .font(.system(size: 18, weight: .medium))
            Picker("Select category", selection: self.$selection) {
                ForEach(T.allCases) { el in
                    Text(String(describing: el)).tag(el)
                }
            }
            .accentColor(.white)
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(RoundedRectangle(cornerRadius: 18).stroke(Color.white.opacity(0.15), lineWidth: 2))
        }
    }
}

enum testEnum : String, CaseIterable, Identifiable {
    case first = "first"
    case second = "second"
    case third = "third"
    
    var id : String {self.rawValue}
}

struct TestViewWrapper : View {
    @State private var selection : testEnum = .first
    
    var body : some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.19)
                .ignoresSafeArea()
            PickerFieldForEnum(name: "testPicker", selection: self.$selection)
        }
    }
}

#Preview {
    TestViewWrapper()
}
