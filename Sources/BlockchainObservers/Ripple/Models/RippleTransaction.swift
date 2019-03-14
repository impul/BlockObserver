//
//  RippleTransaction.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public class RippleTransactionsResult: Codable {
    public var result: String
    public var tx_count: String
    public var ledger: RippleLedger
}

public class RippleLedger: Codable {
    public var hash: String
    public var transactions: [RippleTransaction]
}


public class RippleTransaction: Codable {
    public var hash: String
    public var tx: RippleTransactionDetail
    
}

public class RippleTransactionDetail: Codable {
    public var Account: String
}
