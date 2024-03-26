//
//  LoginUITests.swift
//  MyFinanceAppUITests
//
//  Created by Aruna Udayanga on 26/03/2024.
//

import XCTest

final class LoginUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Assuming the login view is the first view to be displayed
         let emailTextField = app.textFields["Email"]
         XCTAssertTrue(emailTextField.exists)
         emailTextField.tap()
         emailTextField.typeText("Abc@gmail.com")
         
         let passwordSecureField = app.secureTextFields["Password"]
         XCTAssertTrue(passwordSecureField.exists)
         passwordSecureField.tap()
         passwordSecureField.typeText("Abc123456")
         
         let loginButton = app.buttons["LOGIN"]
         XCTAssertTrue(loginButton.exists)
         XCTAssertTrue(loginButton.isEnabled)
         loginButton.tap()
         
         // Replace "TransactionsView" with a unique identifier for an element in the view that appears after successful login.
         // For example, this might be the title of the transactions view if the app navigates to it upon login.
         let transactionsViewTitle = app.staticTexts["Transactions"]
         expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: transactionsViewTitle, handler: nil)
         waitForExpectations(timeout: 5, handler: nil)
         
         XCTAssertTrue(transactionsViewTitle.exists, "The Transactions View did not appear after successful login.")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
