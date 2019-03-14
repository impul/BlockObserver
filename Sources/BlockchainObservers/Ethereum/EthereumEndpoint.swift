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
    case getTransaction(fromBlock: UInt32, toBlock: UInt32)
    
    var rpcMethod: String {
        switch self {
        case .getCurrentBlock:
            return "eth_blockNumber"
        case .getTransaction:
            return "eth_getLogs"
        }
    }
    
    var rpcId: Int {
        return 1
    }
    
    var rpcParametrs: [Any] {
        switch self {
        case .getCurrentBlock:
            return []
        case .getTransaction(let from, let to):
            return [["fromBlock": from.hexString, "toBlock": to.hexString]]
        }
    }
    
    
}
