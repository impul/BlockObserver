//
//  RpcEthereumtransactionList.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public class RpcEthereumtransactionList: RPCModel {
    public let result: EthereumBlockDetail
    
    private enum CodingKeys: String, CodingKey {
        case result
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.result = try container.decode(EthereumBlockDetail.self, forKey: .result)
        try super.init(from: decoder)
    }
}
