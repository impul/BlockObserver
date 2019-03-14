//
//  RippleEndpoint.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

enum RippleRestEndpoint: RequestProtocol {
    case getTransaction(inBlock: String)
    
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
