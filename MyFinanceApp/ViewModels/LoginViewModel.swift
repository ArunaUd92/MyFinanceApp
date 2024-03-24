//
//  LoginViewModel.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 21/03/2024.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    // Dependency on a protocol for authentication to facilitate testing and decoupling.
    private var authUseCase: AuthenticationUseCaseProtocol
    
    // Email string that is being observed for changes to perform validation.
    @Published var email: String = "" {
        didSet {
            // Validates the email every time it changes.
            validateEmail()
        }
    }
    
    // Password string that is being observed for changes to perform validation.
    @Published var password: String = "" {
        didSet {
            // Validates the password every time it changes.
            validatePassword()
        }
    }
    
    // Boolean values published to indicate the validity of the email and password.
    @Published var isEmailValid: Bool = true
    @Published var isPasswordValid: Bool = true
    // Represents the login state of the user.
    @Published var isLoggedIn: Bool = false
    // Stores an error message that can be presented to the user.
    @Published var errorMessage: String? = nil
    // Controls the visibility of an alert, likely in response to an error.
    @Published var showingAlert: Bool = false

    // Initializes the ViewModel with an authentication use case.
    init(authUseCase: AuthenticationUseCaseProtocol) {
        self.authUseCase = authUseCase
    }

    // Attempts to log in the user with the provided credentials.
    func login() {
        // Ensures that both email and password are not empty before proceeding.
        guard !email.isEmpty && !password.isEmpty else {
            showingAlert = true
            errorMessage = "Please fix the errors before logging in."
            return
        }
        
        // Creates a User instance with the provided credentials.
        let user = User(email: email, password: password)
        // Initiates the login process using the authUseCase.
        authUseCase.login(user: user) { [weak self] result in
            // Ensures that the result handling is performed on the main thread.
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

    // Validates the email format.
    private func validateEmail() {
        isEmailValid = email.contains("@") && email.contains(".")
    }

    // Validates the password length.
    private func validatePassword() {
        isPasswordValid = password.count >= 8
    }
}
