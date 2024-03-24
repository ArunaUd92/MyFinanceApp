//
//  AuthenticationService.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 21/03/2024.
//

import Foundation

// Defines a protocol for authentication services, requiring a login method.
protocol AuthenticationServiceProtocol {
    func login(user: User, completion: @escaping (Result<Bool, Error>) -> Void)
}

// An implementation of the AuthenticationServiceProtocol.
class AuthenticationService: AuthenticationServiceProtocol {

    // NetworkService is a dependency for making network requests.
    private let networkService: NetworkServiceProtocol = NetworkService.shared
    
    // Implements the login function.
    func login(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "https://example.com/api/login") else {
            completion(.failure(NSError(domain: "", code: -1001, userInfo: nil)))
            return
        }
        
        // Parameters for the network request are commented out, likely for testing a bypass.
        // let parameters = ["email": user.email, "password": user.password]
        // networkService.request(url: url, method: .post, parameters: parameters, completion: completion)
        
        //---+ Bypassing the authentication API for testing or demonstration purposes +---
        let correctEmail = "Abc@gmail.com"
        let correctPassword = "Abc123456"
        
        // Performs the login check in the background to simulate a network call.
        DispatchQueue.global(qos: .background).async {
            sleep(1) // Sleep for 1 second to simulate a delay
            
            // Checks if the provided credentials match the expected ones.
            if user.email == correctEmail && user.password == correctPassword {
                // If credentials match, return success.
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            } else {
                // If credentials do not match, return failure with an error.
                DispatchQueue.main.async {
                    completion(.failure(AuthenticationError.invalidCredentials))
                }
            }
        }
    }
}


// Defines an error type for authentication failures.
enum AuthenticationError: Error, LocalizedError {
    case invalidCredentials
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid email or password."
        }
    }
}
