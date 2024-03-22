//
//  NetworkService.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 22/03/2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol NetworkServiceProtocol {
    func request<T: Codable>(url: URL, method: HTTPMethod, parameters: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()

    private init() {}


    func request<T: Codable>(url: URL, method: HTTPMethod, parameters: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if method == .post, let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "", code: -1002, userInfo: nil)))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1003, userInfo: nil)))
                return
            }

            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
