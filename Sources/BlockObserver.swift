//
//  BlockObserver.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation
import Logging

public class BlockObserver: BlockchainObserverDelegate {
    private var blockchainsObservers: [BlockchainObserverInterface] = []
    private var logger: PrintLogger
    
    public convenience init(assets: [Asset]) {
        self.init(blockchainsObservers: assets.map {
            return $0.defaultBlockchainObserver
        })
    }
    
    public init(blockchainsObservers: [BlockchainObserverInterface.Type]) {
        logger = PrintLogger()
        self.blockchainsObservers = blockchainsObservers.map {
            return $0.init(delegate: self)
        }
    }
    
    public func addObserver(for address: Address, asset: Asset) {
        blockchainObservers(for: asset).forEach {
            $0.observe(address)
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
        let info = "Did receive tx to \(address), with txId \(txId)"
        logger.info(info)
    }
}
