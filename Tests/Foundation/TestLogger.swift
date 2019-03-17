//
//  TestLogger.swift
//  Async
//
//  Created by Pavlo Boiko on 3/16/19.
//

@testable import BlockObserver
import XCTest


class TestLogger: Logger {
    let testAction: (String) -> Void
    
    init(testAction: @escaping (String) -> Void) {
        self.testAction = testAction
    }
    
    func log(_ string: String) {
        testAction(string)
    }
}
