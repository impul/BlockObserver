//
//  EthereumMiddleware.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public protocol EthereumMiddlewareInterface {
    func getLastBlockNumber(lastBlock: @escaping (UInt32) -> Void)
    func getTransactionInBlockRange(from: UInt32, to: UInt32, transactions: @escaping ([EthereumTransaction]) -> Void)
}

public class EthereumMiddleware: EthereumMiddlewareInterface {
    private let etherRpcNetwork: NetworkManagerInterface
    
    public init(url: String) {
        etherRpcNetwork = NetworkManager(url)
    }
    
    public func getLastBlockNumber(lastBlock: @escaping (UInt32) -> Void) {
        etherRpcNetwork.makeAsyncRequest(EthereumEndpoint.getCurrentBlock) { (result: NetworkResult<RpcCurrentBlock>) in
            switch result {
            case .success(let object):
                lastBlock(object.result.hexToInt)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getTransactionInBlockRange(from: UInt32, to: UInt32, transactions: @escaping ([EthereumTransaction]) -> Void) {
        let endpoint = EthereumEndpoint.getTransaction(fromBlock: from, toBlock: to)
        etherRpcNetwork.makeAsyncRequest(endpoint) { (result: NetworkResult<RpcEthereumtransactionList>) in
            switch result {
            case .success(let object):
                transactions(object.result)
            case .failure(let error):
                print(error)
            }
        }
    }
}
