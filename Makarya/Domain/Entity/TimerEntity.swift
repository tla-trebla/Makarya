//
//  TimerEntity.swift
//  Makarya
//
//  Created by Albert Pangestu on 05/11/21.
//

import Foundation

struct TimerEntity {
    
    typealias Clock = ClockValueObject
    
    let id = UUID()
    let clock: Clock
    let date: Date
    var state: TimerState = .started
    
    init(clock: Clock, date: Date) {
        self.clock = clock
        self.date = date
    }
}

enum TimerState: String, CaseIterable {
    case started = "started"
    case paused = "paused"
    case stopped = "stopped"
    case finished = "finished"
}
