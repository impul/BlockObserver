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
    private var logger: Logger
    private var buffer: TransactionsBufferInterfce
    
    public convenience init(assets: [Asset]) {
        self.init(blockchainsObservers: assets.map {
            return $0.defaultBlockchainObserver
        }, buffer: TransactionsBuffer(capacity: 50),
           logger: PrintLogger())
    }
    
    public init(blockchainsObservers: [BlockchainObserverInterface.Type],
                buffer: TransactionsBufferInterfce,
                logger: Logger) {
        self.logger = logger
        self.buffer = buffer
        self.blockchainsObservers = blockchainsObservers.map {
            return $0.init(delegate: self)
        }
    }
    
    public init(blockchainsObservers: [BlockchainObserverInterface],
                buffer: TransactionsBufferInterfce,
                logger: Logger) {
        self.blockchainsObservers = blockchainsObservers
        self.logger = logger
        self.buffer = buffer
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
    
    public func blockchainObservers(for asset: Asset) -> [BlockchainObserverInterface] {
        return blockchainsObservers.filter({ $0.asset == asset })
    }
    
    public func stopObservers() {
        blockchainsObservers.forEach {
            $0.pauseObserving()
        }
    }
    
    public func startObservers() {
        blockchainsObservers.forEach {
            $0.startObsering()
        }
    }
    
    public var transactions: [Transaction] {
        return buffer.transactions
    }
    
    // MARK: - BlockchainObserverDelegate
    public func didReceive(newStatus: TransactionStatus, onObserver: BlockchainObserverInterface, address: Address, txId: String) {
        let info = "Did receive tx to \(address), with txId \(txId)"
        buffer.append(Transaction(asset: onObserver.asset, txId: txId, receiverAddress: address))
        logger.info(info)
    }
}
