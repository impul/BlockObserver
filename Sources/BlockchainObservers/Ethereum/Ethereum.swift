//
//  Ethereum.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

internal class EthereumBlockchainObserver: DefaultBlockchainObserver {
    override var asset: Asset { return .ethereum }
    private var lastBlock: UInt32?
    
    let endpointMiddlware: EthereumMiddleware
    
    required init(delegate: BlockchainObserverDelegate) {
        let rpcUrl = Asset.ethereum.rpcUrl
        endpointMiddlware = EthereumMiddleware(url: rpcUrl)
        super.init(delegate: delegate)
    }
    
    override func getNewBlocks() {
        endpointMiddlware.getLastBlockNumber(lastBlock: { blockNumber in
            switch (self.lastBlock, blockNumber) {
            // New block not created
            case (blockNumber, blockNumber):
                self.timer?.updateTimer(update: .lessOften)
            // First try
            case (nil, let block):
                self.checkTransactionsInBlocks(from: block, to: block)
                self.timer?.updateTimer(update: .normal)
            // New block(s) created
            case (let oldBlock?, let newBlock):
                self.checkTransactionsInBlocks(from: oldBlock, to: newBlock)
                let newBlocksCount = newBlock - oldBlock
                if newBlocksCount > 1 {
                    self.timer?.updateTimer(update: .moreOften)
                } else {
                    self.timer?.updateTimer(update: .normal)
                }
            }
            self.lastBlock = blockNumber
        })
    }
    
    private func checkTransactionsInBlocks(from: UInt32, to: UInt32) {
        endpointMiddlware.getTransactionInBlockRange(from: from, to: to) { (transactions) in
            transactions.filter({ (tx) -> Bool in
                let isIncomingEthTransaction = self.observedAddresses.contains(tx.address)
                return isIncomingEthTransaction
            }).forEach({ (tx) in
                let txStatus = TransactionStatus.confirmed(confirmations: to - tx.blockNumber.hexToInt)
                self.delegate?.didReceive(newStatus: txStatus,
                                          onObserver: self,
                                          address: tx.address,
                                          txId: tx.transactionHash)
            })
        }
    }
}
