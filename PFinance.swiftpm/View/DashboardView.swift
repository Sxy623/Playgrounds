import SwiftUI
import SwiftData

enum TransactionDisplayType {
    case all
    case income
    case expense
}

struct DashboardView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var paymentActivities: [PaymentActivity]
    
    @State private var showPaymentDetails = false
    @State private var editPaymentDetails = false
    
    private var totalIncome: Double {
        let total = paymentActivities
            .filter {
                $0.type == .income
            }.reduce(0) {
                $0 + $1.amount
            }
        
        return total
    }
    
    private var totalExpense: Double {
        let total = paymentActivities
            .filter {
                $0.type == .expense
            }.reduce(0) {
                $0 + $1.amount
            }
        
        return total
    }
    
    private var totalBalance: Double {
        return totalIncome - totalExpense
    }
    
    private var paymentDataForView: [PaymentActivity] {
        switch listType {
        case .all:
            return paymentActivities
                .sorted(by: { $0.date.compare($1.date) == .orderedDescending })
        case .income:
            return paymentActivities
                .filter { $0.type == .income }
                .sorted(by: { $0.date.compare($1.date) == .orderedDescending })
        case .expense:
            return paymentActivities
                .filter { $0.type == .expense }
                .sorted(by: { $0.date.compare($1.date) == .orderedDescending })
        }
    }
    
    @State private var listType: TransactionDisplayType = .all
    @State private var selectedPaymentActivity: PaymentActivity?
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                MenuBar() {
                    PaymentFormView()
                }
                .listRowInsets(EdgeInsets())
                
                VStack {
                    TotalBalanceCard(totalBalance: totalBalance)
                        .padding(.vertical)
                    
                    HStack(spacing: 15) {
                        IncomeCard(income: totalIncome)
                        ExpenseCard(expense: totalExpense)
                    }
                    .padding(.bottom)
                    
                    TransactionHeader(listType: $listType)
                        .padding(.bottom)
                }
                
                // List the transaction records
                ForEach(paymentDataForView) { transaction in
                    TransactionCellView(transaction: transaction)
                        .onTapGesture {
                            self.showPaymentDetails = true
                            self.selectedPaymentActivity = transaction
                        }
                        .contextMenu {
                            Button {
                                // Edit payment details
                                self.editPaymentDetails = true
                                self.selectedPaymentActivity = transaction
                                
                            } label: {
                                HStack {
                                    Text("Edit")
                                    Image(systemName: "pencil")
                                }
                            }
                            
                            Button {
                                // Delete the selected payment
                                self.delete(payment: transaction)
                            } label: {
                                HStack {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                        }
                }
                .sheet(isPresented: self.$editPaymentDetails) {
                    PaymentFormView(payment: selectedPaymentActivity)
                }
                .sheet(isPresented: $showPaymentDetails) {
                    PaymentDetailView(payment: selectedPaymentActivity!)
                        .presentationDetents([.medium, .large])
                }
            }
            .padding(.horizontal)
            
            if showPaymentDetails {
                BlankView(bgColor: .black)
                    .opacity(0.3)
            }
        }
    }
    
    private func delete(payment: PaymentActivity) {
        self.modelContext.delete(payment)
    }
}

struct MenuBar<Content>: View where Content: View {
    
    @State private var showPaymentForm = false
    let modalContent: () -> Content
    
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack(alignment: .center) {
                Spacer()
                VStack(alignment: .center) {
                    Text(Date.today.string(with: "EEEE, MMM d, yyyy"))
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Text("Personal Finance")
                        .font(.title)
                        .fontWeight(.black)
                }
                Spacer()
            }
            
            Button {
                self.showPaymentForm = true
            } label: {
                Image(systemName: "plus.circle")
                    .font(.title)
                    .foregroundStyle(.primary)
            }
            .sheet(isPresented: self.$showPaymentForm) {
                self.showPaymentForm = false
            } content: {
                self.modalContent()
            }
        }
        
    }
}

struct TotalBalanceCard: View {
    
    var totalBalance = 0.0

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color("TotalBalanceCard"))
                .cornerRadius(15.0)
            VStack {
                Text("Total Balance")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                Text(NumberFormatter.currency(from: totalBalance))
                    .font(.system(size: 80, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .minimumScaleFactor(0.1)
            }
        }
        .frame(height: 200)
    }
}

struct IncomeCard: View {
    
    var income = 0.0
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color("IncomeCard"))
                .cornerRadius(15.0)
            VStack {
                Text("Income")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                Text(NumberFormatter.currency(from: income))
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .minimumScaleFactor(0.1)
            }
        }
        .frame(height: 150)
    }
}

struct ExpenseCard: View {
    
    var expense = 0.0
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color("ExpenseCard"))
                .cornerRadius(15.0)
            VStack {
                Text("Expense")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                    .fixedSize()
                Text(NumberFormatter.currency(from: expense))
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .minimumScaleFactor(0.1)
            }
        }
        .frame(height: 150)
    }
}

struct TransactionHeader: View {
    
    @Binding var listType: TransactionDisplayType
    
    var body: some View {
        VStack {
            HStack {
                Text("Recent transactions")
                    .font(.headline)
                    .foregroundStyle(Color("Heading"))
                Spacer()
            }
            .padding(.bottom, 5)
            
            HStack {
                Group {
                    Text("All")
                        .padding(3)
                        .padding(.horizontal, 10)
                        .background(listType == .all ? Color("PrimaryButton") : Color("SecondaryButton"))
                        .onTapGesture {
                            self.listType = .all
                        }
                    Text("Income")
                        .padding(3)
                        .padding(.horizontal, 10)
                        .background(listType == .income ? Color("PrimaryButton") : Color("SecondaryButton"))
                        .onTapGesture {
                            self.listType = .income
                        }
                    Text("Expense")
                        .padding(3)
                        .padding(.horizontal, 10)
                        .background(listType == .expense ? Color("PrimaryButton") : Color("SecondaryButton"))
                        .onTapGesture {
                            self.listType = .expense
                        }
                }
                .font(.system(.subheadline, design: .rounded))
                .foregroundStyle(.white)
                .cornerRadius(15)
                
                Spacer()
            }
        }
    }
}

struct TransactionCellView: View {
    
    var transaction: PaymentActivity
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: transaction.type == .income ? "arrowtriangle.up.circle.fill" : "arrowtriangle.down.circle.fill")
                .font(.title)
                .foregroundStyle(Color(transaction.type == .income ? "IncomeCard" : "ExpenseCard"))
            VStack(alignment: .leading) {
                Text(transaction.name)
                    .font(.system(.body, design: .rounded))
                Text(transaction.date.string())
                    .font(.system(.caption, design: .rounded))
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text((transaction.type == .income ? "+" : "-") + NumberFormatter.currency(from: transaction.amount))
                .font(.system(.headline, design: .rounded))
        }
        .padding(.vertical, 5)
    }
}

#Preview("Dashboard") {
    DashboardView()
        .modelContainer(previewContainer)
}

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: PaymentActivity.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        for index in 0..<10 {
            let random = Bool.random()
            let newItem = PaymentActivity(
                date: random ? .today : .tomorrow,
                name: random ? "Freelance" : "Flight Ticket",
                amount: random ? 300 : 200,
                type: random ? .income : .expense)
            container.mainContext.insert(newItem)
        }
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
