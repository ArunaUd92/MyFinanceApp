//
//  TransactionsUITests.swift
//  MyFinanceAppUITests
//
//  Created by Aruna Udayanga on 24/03/2024.
//

import XCTest

final class TransactionsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    func testAccountDetailsDisplay() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Check for the presence of account balance and account number
        let balanceText = app.staticTexts["Balance"]
        XCTAssertTrue(balanceText.exists, "Balance text does not exist.")
        
        let accountNumberText = app.staticTexts.matching(identifier: "Account Number:").firstMatch
        XCTAssertTrue(accountNumberText.exists, "Account number is not displayed.")
    
    }
    
    func testTransactionsViewLoads() throws {
        let app = XCUIApplication()
        app.launch()

        // Assuming "Recent Transactions" is unique to the TransactionsView
        let recentTransactionsText = app.staticTexts["Recent Transactions"]

        XCTAssertTrue(recentTransactionsText.exists, "The 'Recent Transactions' text does not exist.")
    }

    func testViewingTransactionDetails() throws {
        let app = XCUIApplication()
        app.launch()

        // Navigate to TransactionsView. Adjust this code based on your actual app navigation.

        // Wait for the "Recent Transactions" text to ensure the view is loaded
        let recentTransactionsText = app.staticTexts["Recent Transactions"]
        let exists = NSPredicate(format: "exists == true")
        
        expectation(for: exists, evaluatedWith: recentTransactionsText, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(recentTransactionsText.exists, "The 'Recent Transactions' text does not exist.")
        
        // Scroll to a transaction. This step might need adjustment based on the actual data and identifiers used.
        let transactionRow = app.staticTexts["TransactionRow.1"] // Adjust based on actual transaction ID
        app.swipeUp() // Adjust scrolling direction if necessary
        XCTAssertTrue(transactionRow.exists, "The transaction row does not exist.")
        
        // Tap the transaction to simulate viewing its details
        transactionRow.tap()
    }
}
