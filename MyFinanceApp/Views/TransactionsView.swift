//
//  TransactionsView.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 22/03/2024.
//

import SwiftUI

struct TransactionsView: View {
    
    @ObservedObject var viewModel = TransactionsViewModel(transactionsUseCase: FetchTransactionsUseCase(transactionsService: TransactionsService()))
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // Welcome and Bank Name
                    Text("Welcome Back,")
                        .font(.title)
                        .fontWeight(.light)
                        .font(.system(size: 24))
                        .padding(.leading, 15.0)
                    Text("Aruna Udayanga")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 15.0)
                        
                    
                    // Balance View
                    VStack(alignment: .leading) {
                        Text("Balance")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(getFormattedDate())
                            .font(.subheadline)
                            .foregroundColor(.white)
                        HStack {
                            Text("Account Number: \(viewModel.accountDetails?.accountNumber ?? "N/A")")
                                .foregroundColor(.white)
                            Spacer()
                            Text("£\(viewModel.accountDetails?.balance ?? 0, specifier: "%.2f")")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(10)
                    .padding()
                    
                    // Recent Transactions
                    VStack(alignment: .leading) {
                        Text("Recent Transactions")
                            .font(.headline)
                            .padding(.leading)
                        ForEach(viewModel.transactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    }
                }
            }
            .onAppear {
                 viewModel.fetchTransactions()
                 viewModel.loadAccountDetails()
             }
        }
        .navigationBarHidden(true)
    }
    
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd, yyyy"
        return dateFormatter.string(from: Date())
    }
}

#Preview {
    TransactionsView()
}

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.right.circle.fill")
                .foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text(transaction.title)
                Text(transaction.subtitle)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(transaction.amount)
                .foregroundColor(transaction.amount.first == "-" ? .red : .green)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
