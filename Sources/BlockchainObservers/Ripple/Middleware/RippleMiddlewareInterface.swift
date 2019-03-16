//
//  RippleMiddlewareInterface.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/16/19.
//

import Foundation

public protocol RippleMiddlewareInterface {
    func getLastBlockNumber(lastBlock: @escaping (UInt64) -> Void)
    func getTransactionInBlockRange(byBlock: UInt64, transactions: @escaping ([RippleTransaction]) -> Void)
}
