//
//  BlockTimerInterface.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/16/19.
//

import Foundation

public enum TickClarify {
    case moreOften
    case lessOften
}

public protocol BlocksTimerInterface {
    func startTimer()
    func pauseTimer()
    
    func updateTimer(update: TickClarify)
    
    var isOn: Bool { get }
}
