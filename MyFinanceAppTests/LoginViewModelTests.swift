//
//  LoginViewModelTests.swift
//  MyFinanceAppTests
//
//  Created by Aruna Udayanga on 24/03/2024.
//

import XCTest
@testable import MyFinanceApp

final class LoginViewModelTests: XCTestCase {

    var viewModel: LoginViewModel!
    var mockAuthUseCase: MockAuthenticationUseCase!
    
    override func setUp() {
        super.setUp()
        mockAuthUseCase = MockAuthenticationUseCase()
        viewModel = LoginViewModel(authUseCase: mockAuthUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAuthUseCase = nil
        super.tearDown()
    }
    
    func testEmailAndPasswordValidation() {
        viewModel.email = "invalidEmail"
        XCTAssertFalse(viewModel.isEmailValid, "Email validation failed.")
        
        viewModel.email = "valid@email.com"
        XCTAssertTrue(viewModel.isEmailValid, "Email validation failed.")
        
        viewModel.password = "short"
        XCTAssertFalse(viewModel.isPasswordValid, "Password validation failed.")
        
        viewModel.password = "validPassword"
        XCTAssertTrue(viewModel.isPasswordValid, "Password validation failed.")
    }
    
    func testLoginSuccess() {
        viewModel.email = "Abc@gmail.com"
        viewModel.password = "Abc123456"
        mockAuthUseCase.result = .success(true)
        
        let expectation = XCTestExpectation(description: "Login success")
        
        viewModel.login()
        DispatchQueue.main.async {
            XCTAssertTrue(self.viewModel.isLoggedIn, "User should be logged in.")
            XCTAssertNil(self.viewModel.errorMessage, "There should be no error message.")
            XCTAssertFalse(self.viewModel.showingAlert, "Alert should not be shown on success.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoginFailure() {
        viewModel.email = "test@test.com"
        viewModel.password = "Abc123"
        mockAuthUseCase.result = .failure(NSError(domain: "", code: -1, userInfo: nil))
        
        let expectation = XCTestExpectation(description: "Login failure")
        
        viewModel.login()
        DispatchQueue.main.async {
            XCTAssertFalse(self.viewModel.isLoggedIn, "User should not be logged in.")
            XCTAssertNotNil(self.viewModel.errorMessage, "There should be an error message.")
            XCTAssertTrue(self.viewModel.showingAlert, "Alert should be shown on failure.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

}
