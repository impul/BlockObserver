//
//  EthereumMiddlewareInterface.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/16/19.
//

import Foundation

public protocol EthereumMiddlewareInterface {
    func getLastBlockNumber(lastBlock: @escaping (UInt64) -> Void)
    func getTransactionsInBlock(block: UInt64, transactions: @escaping ([EthereumTransaction]) -> Void)
}
