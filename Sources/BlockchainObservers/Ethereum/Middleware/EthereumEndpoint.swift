//
//  EthereumEndpoint.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

enum EthereumEndpoint: RPC2RequestProtocol {
    case getCurrentBlock
    case getTransactions(block: UInt64)
    
    var rpcMethod: String {
        switch self {
        case .getCurrentBlock:
            return "eth_blockNumber"
        case .getTransactions:
            return "eth_getBlockByNumber"
        }
    }
    
    var rpcId: Int {
        return 1
    }
    
    var rpcParametrs: [Any] {
        switch self {
        case .getCurrentBlock:
            return []
        case .getTransactions(let block):
            return [block.hexString, true]
        }
    }
}
