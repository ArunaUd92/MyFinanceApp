//
//  AuthenticationUseCase.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 21/03/2024.
//

import Foundation

protocol AuthenticationServiceProtocol {
    func login(user: User, completion: @escaping (Result<Bool, Error>) -> Void)
}

class AuthenticationService: AuthenticationServiceProtocol {
    
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
//    func login(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
//        guard let url = URL(string: "https://example.com/api/login") else {
//            completion(.failure(NSError(domain: "", code: -1001, userInfo: nil)))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try? JSONEncoder().encode(user)
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                completion(.failure(NSError(domain: "", code: -1002, userInfo: nil)))
//                return
//            }
//            
//            completion(.success(true))
//        }.resume()
//    }
    
    func login(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "https://example.com/api/login") else {
            completion(.failure(NSError(domain: "", code: -1001, userInfo: nil)))
            return
        }
        let parameters = ["email": user.email, "password": user.password]
        networkService.request(url: url, method: .post, parameters: parameters, completion: completion)
    }
}
