//
//  RPC2RequestProtocol.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public protocol RPC2RequestProtocol: RequestProtocol {
    var rpcMethod: String { get }
    var rpcId: Int { get }
    var rpcParametrs: [Any] { get }
}

extension RPC2RequestProtocol {
    var path: String {
        return ""
    }
    
    var extraHeaders: HTTPHeader? {
        return nil
    }
    
    var parameters: HTTParametrs? {
        return ["jsonrpc": "2.0",
                "method": rpcMethod,
                "id": rpcId,
                "params": rpcParametrs]
    }
    
    var requestType: RequestType {
        return .post
    }
    
    var contentType: RequestContentType {
        return .json
    }
}
