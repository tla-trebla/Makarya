//
//  CoreDataSaveTimerRepository.swift
//  Makarya
//
//  Created by Albert Pangestu on 17/11/21.
//

import Foundation
import CoreData

final class CoreDataSaveTimerRepository: SaveTimerRepository {
    
    var managedObjectContext: NSManagedObjectContext?
    
    func execute(request: TimerEntity, completion: @escaping (Result<TimerEntity, Error>) -> Void) {
        
        guard let managedObjectContext = managedObjectContext else {
            return completion(.failure(CoreDataError.failedManagedContext))
        }
        
        // Create Clock from CoreData
        let clock = CoreDataClock(context: managedObjectContext)
        clock.hours = Int16(request.clock.hours)
        clock.minutes = Int16(request.clock.minutes)
        clock.seconds = Int16(request.clock.seconds)
        
        // Create Timer from CoreData
        let timer = CoreDataTimer(context: managedObjectContext)
        timer.id = request.id
        timer.ofClock = clock
        timer.date = Date()
        timer.state = request.state.rawValue
        
        do {
            // Save Timer into Persistence Store
            try managedObjectContext.save()
        } catch {
            completion(.failure(error))
        }
        
        // TO-DO: Convert Timer CoreData model into TimerEntity.
        completion(.success(request))
    }
    
    enum CoreDataError: Error {
        case failedManagedContext
    }
}