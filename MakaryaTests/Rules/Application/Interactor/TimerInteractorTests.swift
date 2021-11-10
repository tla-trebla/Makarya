//
//  TimerInteractorTests.swift
//  MakaryaTests
//
//  Created by Albert Pangestu on 05/11/21.
//

import XCTest
@testable import Makarya

class TimerInteractorTests: XCTestCase {

    func testSetTimer_WhenInformationProvided_TimerInStartedState() {
       
        let request = TimerRequestModel(hours: 1, minutes: 0, seconds: 0, date: Date(), state: "")
        
        let sut = SetTimerInteractorImplementation().execute(requestParameter: request)
            
        XCTAssertEqual(sut.state, "started")
    }
    
    func testSetTimer_WhenActionProvided_TimerChangedIntoCorrectState() {
        
        let request = TimerRequestModel(hours: 1, minutes: 0, seconds: 0, date: Date(), state: "paused")
        
        let sut = ChangeTimerActionInteractorImplementation().execute(requestParameter: request)
            
        XCTAssertEqual(sut.state, "paused")
    }

}
