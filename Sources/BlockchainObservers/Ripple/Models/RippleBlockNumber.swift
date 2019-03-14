//
//  RippleBlockNumber.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

struct RippleBlockNumberResponce: Codable {
    var result: RippleBlockNumberResult
}

struct RippleBlockNumberResult: Codable {
    var ledger_index: UInt64
}
