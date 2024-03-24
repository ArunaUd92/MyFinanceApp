//
//  FetchTransactionsUseCase.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 23/03/2024.
//

import Foundation

protocol FetchTransactionsUseCaseProtocol {
    func execute(completion: @escaping (Result<[Transaction], Error>) -> Void)
    func execute(completion: @escaping (Result<AccountDetails, Error>) -> Void)
}

class FetchTransactionsUseCase: FetchTransactionsUseCaseProtocol {
    private var transactionsService: TransactionsServiceProtocol
    
    init(transactionsService: TransactionsServiceProtocol) {
        self.transactionsService = transactionsService
    }
    
    func execute(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        transactionsService.fetchTransactions(completion: completion)
    }
    
    func execute(completion: @escaping (Result<AccountDetails, Error>) -> Void) {
        transactionsService.fetchAccountDetails(completion: completion)
    }
}
