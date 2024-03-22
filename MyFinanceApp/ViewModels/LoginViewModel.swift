//
//  LoginViewModel.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 21/03/2024.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    private var authUseCase: AuthenticationUseCaseProtocol
    @Published var email: String = "" {
        didSet {
            validateEmail()
        }
    }
    @Published var password: String = "" {
        didSet {
            validatePassword()
        }
    }
    @Published var isEmailValid: Bool = true
    @Published var isPasswordValid: Bool = true
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showingAlert: Bool = false

    init(authUseCase: AuthenticationUseCaseProtocol) {
        self.authUseCase = authUseCase
    }

    func login() {
      //   Only attempt login if both email and password pass validation
        guard !email.isEmpty && !password.isEmpty else {
            showingAlert = true
            errorMessage = "Please fix the errors before logging in."
            return
        }
        
        let user = User(email: email, password: password)
        authUseCase.login(user: user) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let isLoggedIn):
                    self?.isLoggedIn = isLoggedIn
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showingAlert = true
                }
            }
        }
    }

    private func validateEmail() {
        isEmailValid = email.contains("@") && email.contains(".")
    }

    private func validatePassword() {
        isPasswordValid = password.count >= 8
    }
}
