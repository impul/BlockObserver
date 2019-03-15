//
//  RippleBlockchainObserver.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

internal class RippleBlockchainObserver: DefaultBlockchainObserver {
    override var asset: Asset { return .ripple }
    private var lastBlock: UInt64?
    
    let endpointMiddlware: RippleMiddlewareInterface
    
    required init(endpointMiddlware: RippleMiddlewareInterface, delegate: BlockchainObserverDelegate) {
        self.endpointMiddlware = endpointMiddlware
        super.init(delegate: delegate)
    }
    
    convenience required init(delegate: BlockchainObserverDelegate) {
        let rpcUrl = Asset.ripple.rpcUrl
        self.init(endpointMiddlware: RippleMiddleware(url: rpcUrl), delegate: delegate)
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
            // New block(s) created
            case (let oldBlock?, let newBlock):
                self.checkTransactionsInBlocks(from: oldBlock, to: newBlock)
                let newBlocksCount = newBlock - oldBlock
                if newBlocksCount > 1 {
                    self.timer?.updateTimer(update: .moreOften)
                }
            }
            self.lastBlock = blockNumber
        })
    }
    
    private func checkTransactionsInBlocks(from: UInt64, to: UInt64) {
        for blockId in from..<to {
            checkTransactionsInBlock(blockId: blockId)
        }
    }
    
    private func checkTransactionsInBlock(blockId: UInt64) {
        endpointMiddlware.getTransactionInBlockRange(byBlock: blockId, transactions: { (transactions) in
            transactions.filter({ (tx) -> Bool in
                let isIncomingTx = self.observedAddresses.contains(tx.tx.Account)
                return isIncomingTx
            }).forEach({ (tx) in
                let txStatus = TransactionStatus.confirmed(confirmations: 1)
                self.delegate?.didReceive(newStatus: txStatus,
                                          onObserver: self,
                                          address: tx.tx.Account,
                                          txId: tx.hash)
            })
        })
    }
}
