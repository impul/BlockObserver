//
//  RPCModel.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public class RPCModel: Codable {
    public let jsonrpc: String
    public let id: UInt32
    
    private enum CodingKeys: String, CodingKey {
        case jsonrpc
        case id
    }
}
