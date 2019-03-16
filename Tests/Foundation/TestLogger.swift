//
//  TestLogger.swift
//  Async
//
//  Created by Pavlo Boiko on 3/16/19.
//

@testable import BlockObserver
@testable import Logging
import XCTest


class TestLogger: Logger {
    let testAction: (String) -> Void
    
    init(testAction: @escaping (String) -> Void) {
        self.testAction = testAction
    }
    
    func log(_ string: String, at level: LogLevel, file: String, function: String, line: UInt, column: UInt) {
        testAction(string)
    }
}
