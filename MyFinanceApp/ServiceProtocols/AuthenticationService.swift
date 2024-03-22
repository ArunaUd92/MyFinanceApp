//
//  AuthenticationService.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 21/03/2024.
//

import Foundation

protocol AuthenticationUseCaseProtocol {
    func login(user: User, completion: @escaping (Result<Bool, Error>) -> Void)
}

class AuthenticationUseCase: AuthenticationUseCaseProtocol {
    private var authService: AuthenticationServiceProtocol
    
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
    
    func login(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        authService.login(user: user, completion: completion)
    }
}
