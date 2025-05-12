import SwiftUI

struct IncomeCategoryDetailView: View {
    
    @EnvironmentObject var incomeDashboardViewModel : IncomeDashboardViewModel
    
    @Binding var isActive : Bool
    
    var categoryName: String

    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.19)
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Button(action: {
                        isActive = false
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 28, weight: .medium))
                            .foregroundColor(Color(white: 0.7))
                    }
                    Spacer()
                }
                Text(self.categoryName)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 32)
                    .padding(.horizontal)
                Text("Incomes")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color.white.opacity(0.7))
                    .padding(.horizontal)
                    .padding(.top, 8)
                List {
                    ForEach(incomeDashboardViewModel.getAllIncomesByCategoryName(categoryName: categoryName), id: \.self) { income in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(income.name)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                Text(income.date.formatted(date: .numeric, time: .omitted))
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.white.opacity(0.5))
                            }
                            Spacer()
                            Text(String(format: "$%.2f", income.amount))
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: deleteIncome)
                }
                .scrollContentBackground(.hidden)
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func deleteIncome(at offsets: IndexSet) {
        let incomes = incomeDashboardViewModel.getAllIncomesByCategoryName(categoryName: categoryName)
        for index in offsets {
            let item = incomes[index]
            incomeDashboardViewModel.deleteIncome(transaction: item)
        }
    }
}

//#Preview {
//    NavigationView {
//        IncomeCategoryDetailView(categoryName: "Salary")
//    }
//}
