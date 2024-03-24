//
//  TransactionsViewModelTests.swift
//  MyFinanceAppTests
//
//  Created by Aruna Udayanga on 24/03/2024.
//

import XCTest
@testable import MyFinanceApp

final class TransactionsViewModelTests: XCTestCase {

    var viewModel: TransactionsViewModel!
    var mockUseCase: MockFetchTransactionsUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchTransactionsUseCase()
        viewModel = TransactionsViewModel(transactionsUseCase: mockUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func testFetchTransactionsSuccess() {
        let expectedTransactions = [
            Transaction(id: "1", title: "", subtitle: "", amount: ""),
            Transaction(id: "2", title: "", subtitle: "", amount: "")
            // Provide actual values as needed
        ]
        mockUseCase.transactionsResult = .success(expectedTransactions)
        
        let expectation = XCTestExpectation(description: "Fetch transactions")
        viewModel.fetchTransactions()
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(self.viewModel.transactions, expectedTransactions, "Transactions should be considered equal")
        XCTAssertFalse(self.viewModel.isLoading)
        XCTAssertNil(self.viewModel.errorMessage)
    }
    
    func testFetchTransactionsFailure() {
        mockUseCase.transactionsResult = .failure(NSError(domain: "TestError", code: -1, userInfo: nil))
        
        let expectation = XCTestExpectation(description: "Fetch transactions failure")
        viewModel.fetchTransactions()
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(self.viewModel.transactions.isEmpty)
        XCTAssertFalse(self.viewModel.isLoading)
        XCTAssertNotNil(self.viewModel.errorMessage)
    }
    
    

}
