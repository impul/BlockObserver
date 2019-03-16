//
//  BlockTimerInterface.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/16/19.
//

import Foundation

public enum TickClarify: Double {
    case moreOften = -1.0
    case lessOften = 1.0
    
    func apply(interval: TimeInterval, coefficient: Double) -> TimeInterval {
        let newInterval = interval + (interval * coefficient * rawValue)
        let isInRange = TickClarify.range.contains(newInterval)
        return isInRange ? newInterval : extremumValue
    }
    
    var extremumValue: TimeInterval {
        switch self {
        case .moreOften:
            return 1
        case .lessOften:
            return 60
        }
    }
    
    static var range: Range<TimeInterval> {
        return TickClarify.moreOften.extremumValue..<TickClarify.lessOften.extremumValue
    }
}

public protocol BlocksTimerInterface {
    func startTimer()
    func pauseTimer()
    
    func updateTimer(update: TickClarify)
    
    var isOn: Bool { get }
}
