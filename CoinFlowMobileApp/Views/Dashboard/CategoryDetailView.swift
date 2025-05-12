import SwiftUI

struct CategoryDetailView: View {
    var categoryName: String
    
    @EnvironmentObject var outcomeDashboardViewModel : OutcomeDashboardViewModel
    
    @Binding var isActive : Bool

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
                .padding(.horizontal)
                .padding(.top, 24)
                Text(self.categoryName)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 32)
                    .padding(.horizontal)
                Text("Spendings")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color.white.opacity(0.7))
                    .padding(.horizontal)
                    .padding(.top, 8)
                List {
                    ForEach(outcomeDashboardViewModel.getAllSpendingsByCategoryName(categoryName: categoryName), id: \.self) { spending in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(spending.name)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                Text(spending.date.formatted(date: .numeric, time: .omitted))
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.white.opacity(0.5))
                            }
                            Spacer()
                            Text(String(format: "$%.2f", spending.amount))
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: deleteSpending)
                }
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func deleteSpending(at offsets: IndexSet) {
        let spendings = outcomeDashboardViewModel.getAllSpendingsByCategoryName(categoryName: categoryName)
        for index in offsets {
            let item = spendings[index]
            outcomeDashboardViewModel.deleteSpending(transaction: item)
        }
    }
}

//#Preview {
//    NavigationView {
//        CategoryDetailView(categoryName: "Auto & Transport")
//    }
//}
