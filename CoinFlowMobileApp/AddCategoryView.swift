import SwiftUI

struct AddCategoryView: View {
    @State private var categoryName: String = ""
    @State private var budgetLimit: String = ""
    @State private var errorMessage: String? = nil
    
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
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Category Name")
                            .foregroundColor(Color.white.opacity(0.5))
                            .font(.system(size: 18, weight: .medium))
                        TextField("Enter category name", text: $categoryName)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 18).stroke(Color.white.opacity(0.15), lineWidth: 2))
                            .foregroundColor(.white)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Budget Limit")
                            .foregroundColor(Color.white.opacity(0.5))
                            .font(.system(size: 18, weight: .medium))
                        TextField("Enter budget limit", text: $budgetLimit)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 18).stroke(Color.white.opacity(0.15), lineWidth: 2))
                            .foregroundColor(.white)
                    }
                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.system(size: 15))
                    }
                }
                .padding(.horizontal, 16)
                Button(action: {
                    // Validate and add category (mock)
                    if categoryName.isEmpty || budgetLimit.isEmpty {
                        errorMessage = "Please fill in all fields."
                    } else if Double(budgetLimit) == nil {
                        errorMessage = "Budget limit must be a number."
                    } else {
                        errorMessage = nil
                        // Add category logic here
                    }
                }) {
                    Text("Add Category")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(red: 1.0, green: 0.6, blue: 0.5), Color(red: 1.0, green: 0.4, blue: 0.3)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(32)
                        .shadow(color: Color(red: 1.0, green: 0.4, blue: 0.3).opacity(0.5), radius: 16, x: 0, y: 8)
                }
                .padding(.horizontal, 16)
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        AddCategoryView()
    }
} 