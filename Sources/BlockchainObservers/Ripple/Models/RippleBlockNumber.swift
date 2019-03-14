//
//  RippleBlockNumber.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

class RippleBlockNumberResponce: Codable {
    var result: RippleBlockNumberResult
}

class RippleBlockNumberResult: Codable {
    var ledger_index: UInt64
}
