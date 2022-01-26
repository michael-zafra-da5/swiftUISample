//
//  SwiftUISampleTests.swift
//  SwiftUISampleTests
//
//  Created by Michael Angelo Zafra on 1/17/22.
//

import XCTest
@testable import SwiftUISample

class SwiftUISampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testLoginViaFirebase() throws {
        let viewModel = LoginViewModel()
        
        let exp = self.expectation(description: "Waiting for async operation")
        viewModel.validate(email: "sample@gmail.com", password: "123456", { result in
            XCTAssertEqual(result, true, "Not Registered")
            exp.fulfill()
        })
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testUnRegLoginViaFirebase() throws {
        let viewModel = LoginViewModel()
        
        let exp = self.expectation(description: "Waiting for async operation")
        viewModel.validate(email: "aaa@gmail.com", password: "123456", { result in
            XCTAssertEqual(result, true, "Not Registered")
            exp.fulfill()
        })
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}
