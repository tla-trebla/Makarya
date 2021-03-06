//
//  UpdatableTimerInteractorTests.swift
//  MakaryaTests
//
//  Created by Albert Pangestu on 12/11/21.
//

import XCTest
@testable import Makarya

class UpdatableTimerInteractorTests: XCTestCase {

    func testChangeTimerAction_WhenActionProvided_TimerChangedIntoCorrectState() {
        
        var request = TimerEntity(clock: ClockValueObject(hours: 1, minutes: 0, seconds: 0), date: Date())
        
        request.state = .paused
            
        attemptChangeTimer(request: request) { result in
            switch result {
            case .success(let timer):
                XCTAssertEqual(timer.state.rawValue, "paused")
            case .failure(let error):
                XCTFail("Should return a timer response model, reason \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Helpers

    func attemptChangeTimer(request: TimerEntity,
                            completion: @escaping (Result<TimerEntity, Error>) -> Void) {
        
        let repository = CoreDataUpdatableTimerRepository(coreDataManager: TestCoreDataManager().create())
        
        let sut = UpdatableTimerInteractor(repository: repository)
        
        sut.update(request) { result in
            switch result {
            case .success(let timer):
                completion(.success(timer))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
