import SwiftUI

struct NumericField: View {
    var fieldName: String
    @Binding var fieldLink: String
    var isDecimal: Bool = true
    @FocusState private var isFocused: Bool  // Используем FocusState для управления фокусом
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(self.fieldName)
                .foregroundColor(Color.white.opacity(0.5))
                .font(.system(size: 15, weight: .medium))
            
            TextField("", text: Binding(
                get: { self.fieldLink },
                set: { newValue in
                    let filtered = self.filterInput(newValue)
                    self.fieldLink = filtered
                })
            )
            .keyboardType(isDecimal ? .decimalPad : .numberPad)
            .autocapitalization(.none)
            .focused($isFocused)  // Привязываем фокус
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.white.opacity(0.15), lineWidth: 2)
            )
            .foregroundColor(.white)
            .toolbar {
                // Добавляем тулбар с кнопкой "Done"
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()  // Оставляем пространство для выравнивания
                    Button("Done") {
                        isFocused = false  // Снимаем фокус с текстового поля, чтобы закрыть клавиатуру
                    }
                }
            }
        }
    }
    
    private func filterInput(_ input: String) -> String {
        let replaced = input.replacingOccurrences(of: ",", with: ".")
        let filtered = replaced.filter { "0123456789.".contains($0) }
        let components = filtered.split(separator: ".", maxSplits: 1, omittingEmptySubsequences: false)
        return components.joined(separator: components.count > 1 ? "." : "")
    }
}

#Preview {
    @Previewable @State var numericText = ""

    ZStack {
        Color(red: 0.15, green: 0.15, blue: 0.19).ignoresSafeArea()
        NumericField(fieldName: "Amount", fieldLink: $numericText)
            .padding()
    }
}

