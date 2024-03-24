//
//  TransactionsViewModel.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 23/03/2024.
//

import Foundation

class TransactionsViewModel: ObservableObject {
    // Use case dependency for fetching transactions and account details.
    private var transactionsUseCase: FetchTransactionsUseCaseProtocol
    
    // Published properties to allow the UI to react to changes.
    @Published var transactions: [Transaction] = [] // Holds a list of transactions.
    @Published var accountDetails: AccountDetails? // Holds account details, if available.
    @Published var isLoading: Bool = false // Indicates if the data is currently loading.
    @Published var errorMessage: String? // Stores error messages for UI display.

    // Initializes with a specific implementation of the transactions use case.
    init(transactionsUseCase: FetchTransactionsUseCaseProtocol) {
        self.transactionsUseCase = transactionsUseCase
    }

    // Fetches transactions and updates the UI accordingly.
    func fetchTransactions() {
        isLoading = true // Marks the start of a loading state.
        transactionsUseCase.execute { [weak self] result in
            DispatchQueue.main.async { // Ensures UI updates are on the main thread.
                self?.isLoading = false // Marks the end of the loading state.
                switch result {
                case .success(let transactions):
                    self?.transactions = transactions // Updates transactions on success.
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription // Stores error message on failure.
                }
            }
        }
    }
    
    // Fetches account details and updates the UI accordingly.
    func loadAccountDetails() {
        isLoading = true // Marks the start of a loading state.
        transactionsUseCase.execute { [weak self] result in
            DispatchQueue.main.async { // Ensures UI updates are on the main thread.
                self?.isLoading = false // Marks the end of the loading state.
                switch result {
                case .success(let details):
                    self?.accountDetails = details // Updates account details on success.
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription // Stores error message on failure.
                }
            }
        }
    }
}
