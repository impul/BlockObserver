//
//  RippleTransaction.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public struct RippleTransactionsResult: Codable {
    public var result: String
    public var ledger: RippleLedger
}

public struct RippleLedger: Codable {
    public var ledger_hash: String
    public var tx_count: String
    public var transactions: [RippleTransaction]
}


public struct RippleTransaction: Codable {
    public var hash: String
    public var tx: RippleTransactionDetail
    
}

public struct RippleTransactionDetail: Codable {
    public var Account: String
}
