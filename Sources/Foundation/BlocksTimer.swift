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
    private let tick: () -> Void
    private let clarifyCoefficient: Double
    private var updatingInterval: TimeInterval
    private var timer: DispatchSourceTimer?
    
    init(startUpdatingIntervar: TimeInterval = 3, clarifyCoefficient: Double = 0.1, tick: @escaping () -> Void) {
        self.updatingInterval = startUpdatingIntervar
        self.tick = tick
        self.clarifyCoefficient = clarifyCoefficient
        activateTimer()
    }
    
    private func activateTimer() {
        timer = DispatchSource.makeTimerSource()
        timer?.schedule(deadline: .now() + self.updatingInterval, repeating: self.updatingInterval)
        timer?.setEventHandler(handler: { [weak self] in
            self?.tick()
        })
        timer?.resume()
    }
    
    func startTimer() {
        restartTimer()
    }
    
    func pauseTimer() {
        timer?.cancel()
    }
    
    func updateTimer(update: TickClarify) {
        let updateValue = updatingInterval * clarifyCoefficient
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
    
    var isOn: Bool {
        return !(timer?.isCancelled ?? true)
    }
    
    func restartTimer() {
        timer?.cancel()
        activateTimer()
    }
    
    #if DEBUG
    var currentUpdateInterval: TimeInterval {
        return updatingInterval
    }
    #endif
}
