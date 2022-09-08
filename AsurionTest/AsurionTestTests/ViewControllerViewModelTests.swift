//
//  ViewControllerViewModelTests.swift
//  AsurionTestTests
//
//  Created by amit.shelgaonkar on 29/08/22.
//

import XCTest
@testable import AsurionTest

class ViewControllerViewModelTests: XCTestCase {
    var controllerViewModel: ViewControllerViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controllerViewModel = ViewControllerViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testcheckOfficehoursTiming() {
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
