import SwiftUI

struct AddTransactionView: View {
    @State private var name = ""
    @State private var description = ""
    @State private var sum = ""
    @State private var selectedCategory = ""
    @State private var selectedTransactionType = TransactionType.outcome
    @State private var errorMessage: String? = nil
    @EnvironmentObject var incomeDashboardViewModel : IncomeDashboardViewModel
    @EnvironmentObject var outcomeDashboardViewModel : OutcomeDashboardViewModel
    @Binding var selectedTab : Int
    var availableCategories: [String] {
        switch selectedTransactionType {
        case .income:
            return incomeDashboardViewModel.allCategories.map {$0.name}
        case .outcome:
            return outcomeDashboardViewModel.allCategories.map {$0.name}
        }
    }

    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.19)
                .ignoresSafeArea()
            VStack {
                ScrollView {
                    VStack(spacing: 32) {
                        Spacer().frame(height: 32)
                        Text("Add Spending")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 24)
                        VStack(alignment: .leading, spacing: 20) {
                            StringField(fieldName: "Name", fieldLink: self.$name, isSecret: false)
                            StringField(fieldName: "Description", fieldLink: self.$description, isSecret: false)
                            PickerFieldForEnum(name: "Transaction Type", selection: $selectedTransactionType)
                            if (availableCategories.isEmpty) {
                                Text("No available values")
                                    .foregroundColor(Color.white.opacity(0.5))
                                    .font(.system(size: 18, weight: .medium))
                            } else {
                                PickerFieldForString(name: "Category", selection: $selectedCategory, choices: availableCategories)
                            }
                            NumericField(fieldName: "Sum", fieldLink: self.$sum, isDecimal: true)
                            if let error = errorMessage {
                                Text(error)
                                    .foregroundColor(.red)
                                    .font(.system(size: 15))
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                LongGradientOrangeButton(text: "Add Spending") {
                    print(self.availableCategories)
                    // Validate and add spending (mock)
                    if self.name.isEmpty || self.description.isEmpty || self.sum.isEmpty {
                        self.errorMessage = "Please fill in all fields."
                    } else if Double(self.sum) == nil {
                        self.errorMessage = "Sum must be a number."
                    } else {
                        self.errorMessage = nil
                        var transaction = Transaction(name: name, date: Date.now, amount: Double(sum)!, categoryName:selectedCategory, transactionType: selectedTransactionType)
                        if (selectedTransactionType == .outcome) {
                            outcomeDashboardViewModel.addNewSpending(transaction: transaction)
                            selectedTab = 0
                        } else {
                            incomeDashboardViewModel.addNewIncome(transaction: transaction)
                            selectedTab = 1
                        }
                        name = ""
                        description = ""
                        sum = ""
                        selectedCategory = "Auto & Transport"
                        selectedTransactionType = TransactionType.outcome
                        errorMessage = nil
                    }
                }
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    NavigationView {
//        AddTransactionView()
//    }
//}
