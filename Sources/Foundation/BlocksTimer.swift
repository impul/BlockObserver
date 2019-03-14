//
//  BlocksTimer.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

enum TickClarify {
    case moreOften
    case lessOften
    case normal
}

fileprivate enum Defaults {
    static var minUpdateInterval: TimeInterval = 1
    static var maxUpdateIntervar: TimeInterval = 60
}

class BlocksTimer {
    private var tick: () -> Void
    private var updatingInterval: TimeInterval
    private var timer: Timer = Timer()
    
    init(startUpdatingIntervar: TimeInterval = 5 , tick: @escaping () -> Void) {
        self.updatingInterval = startUpdatingIntervar
        self.tick = tick
        activateTimer()
    }
    
    private func activateTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: updatingInterval, repeats: false, block: {_ in 
            self.tick()
        })
    }
    
    func endTimer() {
        timer.invalidate()
    }
    
    func updateTimer(update: TickClarify) {
        let updateValue = updatingInterval * 0.1
        switch update {
        case .lessOften:
            if updatingInterval <= Defaults.maxUpdateIntervar {
                updatingInterval += updateValue
            }
        case .moreOften:
            if updatingInterval >= Defaults.minUpdateInterval {
                updatingInterval -= updateValue
            }
        case .normal:
            break
        }
        endTimer()
        activateTimer()
    }
}
