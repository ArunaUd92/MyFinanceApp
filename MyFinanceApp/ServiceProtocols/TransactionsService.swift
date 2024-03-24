//
//  TransactionsService.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 23/03/2024.
//

import Foundation

// Define a protocol to outline required functionalities for a service handling financial transactions and account details.
protocol TransactionsServiceProtocol {
    func fetchTransactions(completion: @escaping (Result<[Transaction], Error>) -> Void)
    func fetchAccountDetails(completion: @escaping (Result<AccountDetails, Error>) -> Void)
}

// Implement the protocol with a concrete class that interacts with a network service to fetch data.
class TransactionsService: TransactionsServiceProtocol {
    // A reference to a shared instance of a network service, assumed to handle the actual network requests.
    private let networkService: NetworkServiceProtocol = NetworkService.shared

    // Implements the function to fetch transactions from a specified URL.
    func fetchTransactions(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        guard let url = URL(string: "https://myfinance.free.beeceptor.com/user/transactions") else {
            completion(.failure(NSError(domain: "", code: -1001, userInfo: nil)))
            return
        }
        networkService.request(url: url, method: .get, parameters: nil, completion: completion)
    }
    
    // Implements the function to fetch account details from a specified URL.
    func fetchAccountDetails(completion: @escaping (Result<AccountDetails, Error>) -> Void) {
        guard let url = URL(string: "https://myfinance.free.beeceptor.com/user/accountdetails") else {
            completion(.failure(NSError(domain: "", code: -1001, userInfo: nil)))
            return
        }
        networkService.request(url: url, method: .get, parameters: nil, completion: completion)
    }
}
