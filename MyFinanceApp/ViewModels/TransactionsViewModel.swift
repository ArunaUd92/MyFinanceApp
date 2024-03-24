//
//  TransactionsViewModel.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 23/03/2024.
//

import Foundation

class TransactionsViewModel: ObservableObject {
    private var transactionsUseCase: FetchTransactionsUseCaseProtocol
    @Published var transactions: [Transaction] = []
    @Published var accountDetails: AccountDetails?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    init(transactionsUseCase: FetchTransactionsUseCaseProtocol) {
        self.transactionsUseCase = transactionsUseCase
    }

    func fetchTransactions() {
        isLoading = true
        transactionsUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let transactions):
                    self?.transactions = transactions
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func loadAccountDetails() {
        isLoading = true
        transactionsUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let details):
                    self?.accountDetails = details
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
