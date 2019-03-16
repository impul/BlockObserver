//
//  BlocksTimer.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

fileprivate enum Defaults {
    static var minUpdateInterval: TimeInterval = 1
    static var maxUpdateIntervar: TimeInterval = 60
}

class BlocksTimer: BlocksTimerInterface {
    private let tick: () -> Void
    private var clarifyCoefficient: Double
    private var updatingInterval: TimeInterval
    private var timer: DispatchSourceTimer?
    
    public init(updatingInterval: TimeInterval = 3, clarifyCoefficient: Double = 0.1, tick: @escaping () -> Void) {
        self.updatingInterval = updatingInterval
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
        timer?.cancel()
        activateTimer()
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
        startTimer()
    }
    
    var isOn: Bool {
        return !(timer?.isCancelled ?? true)
    }
    
    #if DEBUG
    var currentUpdateInterval: TimeInterval {
        return updatingInterval
    }
    #endif
}
