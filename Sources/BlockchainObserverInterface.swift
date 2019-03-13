//
//  BlockchainObserverInterface.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public enum TransactionStatus {
    case registered
    case confirmed(confirmations: UInt64)
}

public protocol BlockchainObserverDelegate: class {
    func didReceive(newStatus: TransactionStatus, onObserver: BlockchainObserverInterface, address: Address, txId: String)
}

public protocol BlockchainObserverInterface {
    init (delegate: BlockchainObserverDelegate)
    var asset: Asset { get }
    
    func observe(_ address: Address)
    func removeObserver(_ address: Address)
}
