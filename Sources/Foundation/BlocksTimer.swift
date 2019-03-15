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
}

fileprivate enum Defaults {
    static var minUpdateInterval: TimeInterval = 1
    static var maxUpdateIntervar: TimeInterval = 60
}

class BlocksTimer {
    private var tick: (BlocksTimer) -> Void
    private var updatingInterval: TimeInterval
    private var timer: Timer = Timer()
    
    public var isOn: Bool
    
    init(startUpdatingIntervar: TimeInterval = 5 , tick: @escaping (BlocksTimer) -> Void) {
        self.updatingInterval = startUpdatingIntervar
        self.tick = tick
        self.isOn = true
        activateTimer()
    }
    
    private func activateTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: self.updatingInterval,
                                          target: self,
                                          selector: #selector(self.tickAction),
                                          userInfo: nil,
                                          repeats: false)
        RunLoop.current.add(timer, forMode: .common)
    }
    
    @objc public func tickAction() {
        if self.isOn {
            self.tick(self)
            restartTimer()
        }
    }
    
    func startTimer() {
        self.isOn = true
        activateTimer()
    }
    
    func pauseTimer() {
        self.isOn = false
        timer.invalidate()
    }
    
    func updateTimer(update: TickClarify) {
        if !isOn { return }
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
        }
        restartTimer()
    }
    
    func restartTimer() {
        timer.invalidate()
        activateTimer()
    }
}
