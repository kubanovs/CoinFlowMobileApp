import SwiftUI

struct AddOutcomeCategoryView: View {
    @State private var categoryName = ""
    @State private var budgetLimit = ""
    @State private var errorMessage: String? = nil
    @Binding var isActive: Bool
    @EnvironmentObject var outcomeDashboardViewModel : OutcomeDashboardViewModel

    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.19)
                .ignoresSafeArea()
            VStack(spacing: 32) {
                Spacer().frame(height: 32)
                Text("Add New Category")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 24)
                VStack(alignment: .leading, spacing: 20) {
                    StringField(fieldName: "Category Name", fieldLink: self.$categoryName, isSecret: false)
                    NumericField(fieldName: "Budget Limit", fieldLink: self.$budgetLimit, isDecimal: true)
                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.system(size: 15))
                    }
                }
                .padding(.horizontal, 16)
                LongGradientOrangeButton(text: "Add Category") {
                    // Validate and add category (mock)
                    if self.categoryName.isEmpty || self.budgetLimit.isEmpty {
                        self.errorMessage = "Please fill in all fields."
                    } else if Double(self.budgetLimit) == nil {
                        self.errorMessage = "Budget limit must be a number."
                    } else {
                        self.errorMessage = nil
                        outcomeDashboardViewModel.addNewCategory(categoryName: self.categoryName, limit: Double(self.budgetLimit)!)
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
                AddOutcomeCategoryView(isActive: $isActive)
            }
        }
    }

    return PreviewWrapper()
}
