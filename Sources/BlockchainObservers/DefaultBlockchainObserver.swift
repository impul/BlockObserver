//
//  DefaultBlockchainObserver.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

class DefaultBlockchainObserver: BlockchainObserverInterface {
    private weak var delegate: BlockchainObserverDelegate?
    private var observedAddresses: Set<Address> = []
    
    required init(delegate: BlockchainObserverDelegate) {
        self.delegate = delegate
    }
    
    var asset: Asset {
        fatalError("shold override")
    }
    
    func observe(_ address: Address) {
        observedAddresses.insert(address)
    }
    
    func removeObserver(_ address: Address) {
        observedAddresses.remove(address)
    }
}
