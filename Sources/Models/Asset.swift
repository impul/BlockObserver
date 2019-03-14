//
//  Asset.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public enum Asset {
    case ethereum
    case ripple
    
    var defaultBlockchainObserver: BlockchainObserverInterface.Type {
        switch self {
        case .ethereum:
            return EthereumBlockchainObserver.self
        case .ripple:
            return RippleBlockchainObserver.self
        }
    }
    
    var rpcUrl: String {
        switch self {
        case .ethereum:
            return "http://ethereum-rpc.trustwalletapp.com"
        case .ripple:
            return "http://ripple-rpc.trustwalletapp.com"
        }
    }
}
