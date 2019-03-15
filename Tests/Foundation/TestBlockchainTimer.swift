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
        timer1 = BlocksTimer(startUpdatingIntervar: 2, tick: {
            tickCount += 1
            if tickCount == 2 {
                self.timer1?.pauseTimer()
                self.timer1?.startTimer()
            }
            if tickCount == 3 {
                expect.fulfill()
                self.timer1?.pauseTimer()
            }
        })
        wait(for: [expect], timeout: 10)
    }
    
    func testTimerLessUpdate() {
        let expect = expectation(description: "Timers less often")
        var tickCount = 0
        timer2 = BlocksTimer(startUpdatingIntervar: 2, tick: {
            tickCount += 1
            self.timer2?.updateTimer(update: .moreOften)
            if tickCount == 3 {
                expect.fulfill()
                self.timer2?.pauseTimer()
            }
        })
        wait(for: [expect], timeout: 10)
    }
}
