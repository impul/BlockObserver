//
//  RippleEndpoint.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

enum RippleRestEndpoint: RequestProtocol {
    case getTransaction(inBlock: UInt64)
    
    var path: String {
        switch self {
        case .getTransaction(let block):
            return "ledgers/\(block)?transactions=true&binary=false&expand=true"
        }
    }
    
    var extraHeaders: HTTPHeader? {
        return nil
    }
    
    var parameters: HTTParametrs? {
        return nil
    }
    
    var requestType: RequestType {
        return .get
    }
    
    var contentType: RequestContentType {
        return .json
    }
}

enum RippleRpcEndpoint: RPC2RequestProtocol {
    case getCurrentBlock
    
    var rpcMethod: String {
        switch self {
        case .getCurrentBlock:
            return "ledger"
        }
    }
    
    var rpcId: Int {
        return 1
    }
    
    var rpcParametrs: [Any] {
        switch self {
        case .getCurrentBlock:
            return [["ledger_index": "validated",
                     "accounts": false,
                     "full": false,
                     "transactions": false,
                     "expand": false,
                     "owner_funds": false]]
        }
    }
}
