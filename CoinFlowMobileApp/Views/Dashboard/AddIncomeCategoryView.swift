import SwiftUI

struct AddIncomeCategoryView: View {
    @State private var categoryName = ""
    @State private var incomeSum = ""
    @State private var errorMessage: String? = nil
    @EnvironmentObject var incomeDashboardViewModel : IncomeDashboardViewModel
    @Binding var isActive : Bool

    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.19)
                .ignoresSafeArea()
            VStack(spacing: 32) {
                Spacer().frame(height: 32)
                Text("Add Income Category")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 24)
                VStack(alignment: .leading, spacing: 20) {
                    StringField(fieldName: "Category Name", fieldLink: self.$categoryName, isSecret: false)
                    NumericField(fieldName: "Income Sum", fieldLink: self.$incomeSum)
                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.system(size: 15))
                    }
                }
                .padding(.horizontal, 16)
                LongGradientOrangeButton(text: "Add Category") {
                    // Validate and add category (mock)
                    if self.categoryName.isEmpty || self.incomeSum.isEmpty {
                        self.errorMessage = "Please fill in all fields."
                    } else if Double(self.incomeSum) == nil {
                        self.errorMessage = "Income sum must be a number."
                    } else {
                        self.errorMessage = nil
                        incomeDashboardViewModel.addNewCategory(categoryName: self.categoryName, income: Double(self.incomeSum)!)
                        self.isActive = false
                    }
                }
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var isActive = false

        var body: some View {
            NavigationView {
                AddIncomeCategoryView(isActive: $isActive)
            }
        }
    }

    return PreviewWrapper()
}
