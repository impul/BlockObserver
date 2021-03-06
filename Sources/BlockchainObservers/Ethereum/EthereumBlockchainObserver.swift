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
    private var lastBlock: UInt64?
    
    let endpointMiddlware: EthereumMiddlewareInterface
    
    required init(endpointMiddlware: EthereumMiddlewareInterface = EthereumMiddleware(url: Asset.ethereum.rpcUrl),
                  delegate: BlockchainObserverDelegate?) {
        self.endpointMiddlware = endpointMiddlware
        super.init(delegate: delegate)
    }
    
    public convenience required init(delegate: BlockchainObserverDelegate?) {
        let rpcUrl = Asset.ripple.rpcUrl
        self.init(endpointMiddlware: EthereumMiddleware(url: rpcUrl), delegate: delegate)
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
            checkTransactionsInBlock(block: blockId)
        }
    }
    
    private func checkTransactionsInBlock(block: UInt64) {
        endpointMiddlware.getTransactionsInBlock(block: block) { (transactions) in
            transactions.filter({ (tx) -> Bool in
                let isIncomingEthTransaction = self.observedAddresses.contains(tx.to)
                return isIncomingEthTransaction
            }).forEach({ (tx) in
                let txStatus = TransactionStatus.confirmed(confirmations: (self.lastBlock ?? block) - block)
                self.delegate?.didReceive(newStatus: txStatus,
                                          onObserver: self,
                                          address: tx.to,
                                          txId: tx.hash)
            })
        }
    }
}
