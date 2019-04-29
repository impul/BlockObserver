//
//  BlockObserver.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public class BlockObserver: BlockchainObserverDelegate {
    private let blockchainsObservers: [BlockchainObserverInterface]
    private let notifier: TransactionNotifier
    
    /// Init with custom blockchain observer realizations
    ///
    /// - Parameters:
    ///   - blockchainsObservers: array with blockchain observer objects
    ///   - logger: log new transactions
    public init(blockchainsObservers: [BlockchainObserverInterface], notifier: TransactionNotifier) {
        self.blockchainsObservers = blockchainsObservers
        self.notifier = notifier
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
    
    // MARK: - BlockchainObserverDelegate
    public func didReceive(newStatus: TransactionStatus, onObserver: BlockchainObserverInterface, address: Address, txId: String) {
        let transaction = Transaction(asset: onObserver.asset, txId: txId, receiverAddress: address)
        notifier.log(transaction)
    }
}
