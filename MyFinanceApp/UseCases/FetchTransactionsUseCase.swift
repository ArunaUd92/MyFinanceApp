//
//  FetchTransactionsUseCase.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 23/03/2024.
//

import Foundation

// Protocol for fetching transactions or account details use cases.
protocol FetchTransactionsUseCaseProtocol {
    func execute(completion: @escaping (Result<[Transaction], Error>) -> Void)
    func execute(completion: @escaping (Result<AccountDetails, Error>) -> Void)
}

// Implements protocol to fetch transactions or account details using a service.
class FetchTransactionsUseCase: FetchTransactionsUseCaseProtocol {
    // Service for accessing transaction data.
    private var transactionsService: TransactionsServiceProtocol
    
    // Initializes with a transactions service.
    init(transactionsService: TransactionsServiceProtocol) {
        self.transactionsService = transactionsService
    }
    
    // Fetches transactions and returns them via the completion handler.
    func execute(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        transactionsService.fetchTransactions(completion: completion)
    }
    
    // Fetches account details and returns them via the completion handler.
    func execute(completion: @escaping (Result<AccountDetails, Error>) -> Void) {
        transactionsService.fetchAccountDetails(completion: completion)
    }
}
