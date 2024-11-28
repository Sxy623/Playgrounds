import SwiftUI

struct PaymentDetailView: View {
    
    let payment: PaymentActivity
    
    private let viewModel: PaymentDetailViewModel
    
    init(payment: PaymentActivity) {
        self.payment = payment
        self.viewModel = PaymentDetailViewModel(payment: payment)
    }
    
    var body: some View {
        VStack {
            TitleBar(viewModel: self.viewModel)
                .padding(.top, 10)
            
            Image(self.viewModel.image)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 0, maxWidth: .infinity)
            
            // Payment details
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(self.viewModel.name)
                        .font(.system(.headline))
                        .fontWeight(.semibold)
                    Text(self.viewModel.date)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("Subheadline"))
                    Text(self.viewModel.address)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("Subheadline"))
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(self.viewModel.amount)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .padding(.trailing)
            }
            
            Divider()
                .padding(.horizontal)
            
            if self.viewModel.memo != "" {
                Group {
                    Text("Memo")
                        .font(.subheadline)
                        .bold()
                        .padding(.bottom, 5)
                    
                    Text(self.viewModel.memo)
                        .font(.subheadline)
                    
                    Divider()
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
            
            Spacer()
        }
    }
}

#Preview {
    PaymentDetailView(payment: PaymentActivity(date: .today, name: "Flight Ticket", amount: 2000, type: .expense))
}

struct TitleBar: View {
    var viewModel: PaymentDetailViewModel
    
    var body: some View {
        HStack {
            Text("Payment Details")
                .font(.headline)
                .foregroundStyle(Color("Heading"))
            
            Image(systemName: viewModel.typeIcon)
                .foregroundStyle(Color("ExpenseCard"))
            
            Spacer()
        }
        .padding()
    }
}
