//
//  NetworkService.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 22/03/2024.
//

import Foundation

// Enum to define the type of HTTP request method.
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

// Protocol defining the requirements for a network service, including a generic request function.
protocol NetworkServiceProtocol {
    func request<T: Codable>(url: URL, method: HTTPMethod, parameters: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void)
}

// Singleton class implementing the NetworkServiceProtocol.
class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()

    private init() {}


    func request<T: Codable>(url: URL, method: HTTPMethod, parameters: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Attaches parameters as a JSON body for POST requests.
        if method == .post, let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }

        // Asynchronously performs the HTTP request.
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Error handling.
            if let error = error {
                completion(.failure(error))
                return
            }

            // Status code validation.
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "", code: -1002, userInfo: nil)))
                return
            }

            // Data availability check.
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1003, userInfo: nil)))
                return
            }

            // Attempts to decode the response data into the specified generic type T.
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
