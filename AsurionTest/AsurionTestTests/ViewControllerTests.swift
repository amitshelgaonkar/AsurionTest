//
//  ViewControllerTests.swift
//  AsurionTestTests
//
//  Created by amit.shelgaonkar on 29/08/22.
//

import XCTest
@testable import AsurionTest
class ViewControllerTests: XCTestCase {
    var controllerViewModel: ViewControllerViewModel?
    var sut: ViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
         sut  = ViewController()
    }
    
  
    func testfetchPetDataFromAPISuccess() {
        let expectation = XCTestExpectation(description: "PetApi expectation Success")
        controllerViewModel?.getPetAPIData(param: nil, completion: { petModel, error in
            self.sut.petsArray = petModel?.pets
            expectation.fulfill()
        })
        
        XCTWaiter().wait(for: [expectation], timeout: 1.0)
    }
    
    func testfetchPetDataFromAPIFailure() {
        let expectation = XCTestExpectation(description: "PetApi expectation Failure")
        controllerViewModel?.getPetAPIData(param: nil, completion: { petModel, error in
            XCTFail()
            expectation.fulfill()
            XCTAssertNil(ServiceError(httpStatus: 500, message: "Something Went Wrong!!"))
        })
        
        XCTWaiter().wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchConfigDataFromAPISuccess() {
        let expectation = XCTestExpectation(description: "Config Api expectation success")
        
        controllerViewModel?.getConfigAPIData(param: nil, completion: { configModel, error in
            self.sut.configSettings = configModel?.settings
            expectation.fulfill()
        })
        XCTWaiter().wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchConfigDataFromAPIFailure() {
        let expectation = XCTestExpectation(description: "Config Api expectation Failure")
        controllerViewModel?.getConfigAPIData(param: nil, completion: { configModel, error in
            XCTFail()
            expectation.fulfill()
            XCTAssertNil(ServiceError(httpStatus: 500, message: "Something Went Wrong!"))
        })
        XCTWaiter().wait(for: [expectation], timeout: 1.0)
    }
    
    func testshowDefaultAlertwith() {
        sut.showDefaultAlertwith(errorTitle: "Error", message: "Something Went Wrong!")
        sut.showDefaultAlertwith(errorTitle: "", message: "Thank you for getting in touch with us. We’ll get back to you as soon as possible")

    }
    
    func testcheckOfficehoursTiming() {
        let workHourFailCheck = sut.controllerViewModel?.checkOfficehoursTiming(workingHours: nil, todaysDateString: "12:00", WeekDay: 2)
        let todaysStringFailCheck = sut.controllerViewModel?.checkOfficehoursTiming(workingHours: nil, todaysDateString: "19:00", WeekDay: 2)
        let weekend = sut.controllerViewModel?.checkOfficehoursTiming(workingHours: nil, todaysDateString: "13:00", WeekDay: 7)
        let workHourSuccessCheck = sut.controllerViewModel?.checkOfficehoursTiming(workingHours: "M-F 9:00 - 18:00", todaysDateString: Utility().getTodayString().0, WeekDay: 2)
        
        XCTAssertFalse(workHourFailCheck ?? false)
        XCTAssertFalse(todaysStringFailCheck ?? false)
        XCTAssertFalse(weekend ?? false)
        XCTAssertTrue(workHourSuccessCheck ?? true)
    }
    
    func testsetScheduleTiming() {
        sut.callButton?.isHidden = !(sut.configSettings?.isCallEnabled ?? false)
        sut.chatButton?.isHidden = !(sut.configSettings?.isChatEnabled ?? false)
        sut.scheduleLable?.text = "Office Hours:  \(sut.configSettings?.workHours ?? "")"
    }
    
  
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
}
