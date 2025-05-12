import SwiftUI

struct AddIncomeView: View {
    @State private var name = ""
    @State private var description = ""
    @State private var sum = ""
    @State private var selectedCategory = "Salary"
    @State private var errorMessage: String? = nil

    let categories = ["Salary", "Gift"]

    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.19)
                .ignoresSafeArea()
            VStack(spacing: 32) {
                Spacer().frame(height: 32)
                Text("Add Income")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 24)
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name")
                            .foregroundColor(Color.white.opacity(0.5))
                            .font(.system(size: 18, weight: .medium))
                        TextField("Enter name", text: self.$name)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 18).stroke(Color.white.opacity(0.15), lineWidth: 2))
                            .foregroundColor(.white)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .foregroundColor(Color.white.opacity(0.5))
                            .font(.system(size: 18, weight: .medium))
                        TextField("Enter description", text: self.$description)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 18).stroke(Color.white.opacity(0.15), lineWidth: 2))
                            .foregroundColor(.white)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Category")
                            .foregroundColor(Color.white.opacity(0.5))
                            .font(.system(size: 18, weight: .medium))
                        Picker("Select category", selection: self.$selectedCategory) {
                            ForEach(self.categories, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 18).stroke(Color.white.opacity(0.15), lineWidth: 2))
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Income Sum")
                            .foregroundColor(Color.white.opacity(0.5))
                            .font(.system(size: 18, weight: .medium))
                        TextField("Enter income sum", text: self.$sum)
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
                    // Validate and add income (mock)
                    if self.name.isEmpty || self.description.isEmpty || self.sum.isEmpty {
                        self.errorMessage = "Please fill in all fields."
                    } else if Double(self.sum) == nil {
                        self.errorMessage = "Income sum must be a number."
                    } else {
                        self.errorMessage = nil
                        // Add income logic here
                    }
                }) {
                    Text("Add Income")
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
        AddIncomeView()
    }
}
