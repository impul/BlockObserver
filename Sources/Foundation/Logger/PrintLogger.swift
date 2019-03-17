//
//  PrintLogger.swift
//  Async
//
//  Created by Pavlo Boiko on 3/17/19.
//

import Foundation

public class BlockPrintLogger: BlockLogger {
    public func log(_ string: String) {
        Swift.print(string)
    }
}
