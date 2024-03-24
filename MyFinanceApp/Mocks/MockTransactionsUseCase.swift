//
//  MockTransactionsUseCase.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 24/03/2024.
//

import Foundation

class MockFetchTransactionsUseCase: FetchTransactionsUseCaseProtocol {
    var transactionsResult: Result<[Transaction], Error>?
    var accountDetailsResult: Result<AccountDetails, Error>?
    
    func execute(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        if let result = transactionsResult {
            completion(result)
        }
    }
    
    func execute(completion: @escaping (Result<AccountDetails, Error>) -> Void) {
        if let result = accountDetailsResult {
            completion(result)
        }
    }
}
