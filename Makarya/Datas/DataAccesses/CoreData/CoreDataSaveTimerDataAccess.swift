//
//  CoreDataSaveTimerDataAccess.swift
//  Makarya
//
//  Created by Albert Pangestu on 17/11/21.
//

import Foundation
import CoreData

final class CoreDataSaveTimerDataAccess: SaveTimerDataAccess {
    
    var managedObjectContext: NSManagedObjectContext?
    
    func execute(request: TimerEntity, completion: @escaping (Result<TimerEntity, Error>) -> Void) {
        
        guard let managedObjectContext = managedObjectContext else {
            completion(.failure(CoreDataError.failedManagedContext))
        }
        
        // Create Clock from CoreData
        let clock = Clock(context: managedObjectContext)
        clock.hours = Int16(request.clock.hours)
        clock.minutes = Int16(request.clock.minutes)
        clock.seconds = Int16(request.clock.seconds)
        
        // Create Timer from CoreData
        let timer = Timer(context: managedObjectContext)
    }
    
    enum CoreDataError: Error {
        case failedManagedContext
    }
}
