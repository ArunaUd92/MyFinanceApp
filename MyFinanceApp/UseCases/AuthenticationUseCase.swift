//
//  AuthenticationUseCase.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 21/03/2024.
//

import Foundation

// Protocol defining the requirements for an authentication use case.
protocol AuthenticationUseCaseProtocol {
    func login(user: User, completion: @escaping (Result<Bool, Error>) -> Void)
}

// Implementation of the authentication use case.
class AuthenticationUseCase: AuthenticationUseCaseProtocol {
    // Holds a reference to an object that conforms to the AuthenticationServiceProtocol.
    private var authService: AuthenticationServiceProtocol
    
    // Initializes with a specific authentication service.
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
    
    // Passes the login request to the authentication service.
    func login(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        authService.login(user: user, completion: completion)
    }
}
