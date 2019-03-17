//
//  EthereumTransaction.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public struct EthereumBlockDetail: Codable {
    var transactions: [EthereumTransaction]
}

public struct EthereumTransaction: Codable {
    var from: String
    var hash: String
    var value: String
    var blockNumber: String
    var to: String
    var input: String
}


