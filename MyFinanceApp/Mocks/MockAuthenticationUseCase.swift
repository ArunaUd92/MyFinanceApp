//
//  MockAuthenticationUseCase.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 24/03/2024.
//

import Foundation

class MockAuthenticationUseCase: AuthenticationUseCaseProtocol {
    var result: Result<Bool, Error>?
    
    func login(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
