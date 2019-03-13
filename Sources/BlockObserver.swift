//
//  BlockObserver.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public class BlockObserver: BlockchainObserverDelegate {
    private var blockchainsObservers: [BlockchainObserverInterface] = []
    
    public init(blockchainsObservers: [BlockchainObserverInterface.Type]) {
        self.blockchainsObservers = blockchainsObservers.map {
            return $0.init(delegate: self)
        }
    }
    
    public func addObserver(for address: Address, asset: Asset, mode: ObservingeMode = .all) {
        blockchainObservers(for: asset).forEach {
            $0.observe(address, withMode: mode)
        }
    }
    
    public func removeObserver(for address: Address, asset: Asset) {
        blockchainObservers(for: asset).forEach {
            $0.removeObserver(address)
        }
    }
    
    private func blockchainObservers(for asset: Asset) -> [BlockchainObserverInterface] {
        return blockchainsObservers.filter({ $0.asset == asset })
    }
    
    // MARK: - BlockchainObserverDelegate
    public func didReceive(newStatus: TransactionStatus, onObserver: BlockchainObserverInterface, address: Address, txId: String) {
        
    }
}
