//
//  AddableTimerInteractor.swift
//  Makarya
//
//  Created by Albert Pangestu on 05/11/21.
//

import Foundation

enum AddableInteractorError: Error {
    case invalidHours
    case invalidMinutes
    case invalidSeconds
    case repositoryError
}

protocol AddableInteractor {
    
    associatedtype Request
    associatedtype Response
    associatedtype InteractorError: Error
    
    typealias AddableTimerInteractorCompletion = (Result<Response, InteractorError>) -> Void
    func add(_ request: Request, completion: @escaping (AddableTimerInteractorCompletion))
}

final class AddableTimerInteractor: AddableInteractor {
    
    typealias Request = TimerEntity
    typealias Response = TimerEntity
    typealias InteractorError = AddableInteractorError
    
    private let repository: AddableTimerRepository
    
    init(repository: AddableTimerRepository) {
        self.repository = repository
    }
    
    func add(_ request: Request, completion: @escaping (AddableTimerInteractorCompletion)) {
        
        // Validate the request
        guard 0...23 ~= request.clock.hours else {
            return completion(.failure(.invalidHours))
        }
        
        guard 0...60 ~= request.clock.minutes else {
            return completion(.failure(.invalidMinutes))
        }
        
        guard 0...60 ~= request.clock.seconds else {
            return completion(.failure(.invalidSeconds))
        }
        
        repository.execute(timer: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(_):
                completion(.failure(.repositoryError))
            }
        }
            
    }
}
