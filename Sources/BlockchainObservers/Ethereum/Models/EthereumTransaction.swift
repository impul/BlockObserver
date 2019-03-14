//
//  EthereumTransaction.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public struct EthereumTransaction: Codable {
    var type: String
    var blockHash: String
    var transactionHash: String
    var transactionIndex: String
    var topics: [String]
    var blockNumber: String
    var address: String
    var transactionLogIndex: String
    var logIndex :String
    var removed: Bool
    var data: String
}
