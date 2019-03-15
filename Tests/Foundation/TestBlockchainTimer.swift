//
//  TestBlockchainTimer.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

@testable import BlockObserver
import XCTest

class  TestBlockchainTimer: XCTestCase {
    private var timer1: BlocksTimer?
    private var timer2: BlocksTimer?

    func testTimer() {
        let expect = expectation(description: "Timers tick")
        var tickCount = 0
        timer1 = BlocksTimer(startUpdatingIntervar: 2, tick: { timer in
            tickCount += 1
            if tickCount == 2 {
                timer.pauseTimer()
                timer.startTimer()
            }
            if tickCount == 3 {
                expect.fulfill()
                timer.pauseTimer()
            }
        })
        wait(for: [expect], timeout: 10)
    }
    
    func testTimerLessUpdate() {
        let expect = expectation(description: "Timers less often")
        var tickCount = 0
        timer2 = BlocksTimer(startUpdatingIntervar: 2, tick: { timer in
            tickCount += 1
            self.timer2?.updateTimer(update: .moreOften)
            if tickCount == 3 {
                expect.fulfill()
                timer.pauseTimer()
            }
        })
        wait(for: [expect], timeout: 10)
    }
}
