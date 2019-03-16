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
    private var timer: BlocksTimer?
    private var tickCount: Int = 0
    
    override func setUp() {
        timer = nil
        tickCount = 0
    }

    func testTimer() {
        let expect = expectation(description: "Timers tick")
        timer = BlocksTimer(updatingInterval: 2, tick: {
            self.tickCount += 1
            if self.tickCount == 2 {
                self.timer?.pauseTimer()
                self.timer?.startTimer()
            }
            if self.tickCount == 3 {
                expect.fulfill()
                self.timer?.pauseTimer()
            }
        })
        wait(for: [expect], timeout: 10)
    }
    
    func testTimerLessUpdate() {
        let expect = expectation(description: "Timers less often")
        timer = BlocksTimer(updatingInterval: 2, tick: {
            self.tickCount += 1
            self.timer?.updateTimer(update: .moreOften)
            if self.tickCount == 3 {
                expect.fulfill()
                self.timer?.pauseTimer()
            }
        })
        wait(for: [expect], timeout: 10)
    }
    
    func testTimerClariffing() {
        // 1 -> 1.2 -> 1.44
        let expect = expectation(description: "Timers less often")
        timer = BlocksTimer.init(updatingInterval: 1, clarifyCoefficient: 0.2) {
            self.tickCount += 1
            self.timer?.updateTimer(update: .lessOften)
            if self.tickCount == 2 {
                XCTAssertEqual(self.timer?.currentUpdateInterval, 1.44)
                expect.fulfill()
                self.timer?.pauseTimer()
            }
        }
        wait(for: [expect], timeout: 5)
    }
}
