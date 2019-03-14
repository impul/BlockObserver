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

    func testTimer() {
        let expect = expectation(description: "Timers tick")
        var tickCount = 0
        timer = BlocksTimer(startUpdatingIntervar: 2, tick: { timer in
            tickCount += 1
            timer.updateTimer(update: .normal)
            if tickCount == 3 {
                timer.pauseTimer()
                expect.fulfill()
            }
        })
        wait(for: [expect], timeout: 10)
    }
}
