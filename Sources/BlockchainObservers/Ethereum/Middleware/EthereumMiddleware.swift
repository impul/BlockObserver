//
//  EthereumMiddleware.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public class EthereumMiddleware: EthereumMiddlewareInterface {
    private let etherRpcNetwork: NetworkManagerInterface
    
    public init(networkManager: NetworkManagerInterface) {
        self.etherRpcNetwork = networkManager
    }
    
    public convenience init(url: String) {
        self.init(networkManager: NetworkManager(url))
    }
    
    public func getLastBlockNumber(lastBlock: @escaping (UInt64) -> Void) {
        etherRpcNetwork.makeAsyncRequest(EthereumEndpoint.getCurrentBlock) { (result: NetworkResult<RpcCurrentBlock>) in
            switch result {
            case .success(let object):
                lastBlock(object.result.hexToInt)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getTransactionsInBlock(block: UInt64, transactions: @escaping ([EthereumTransaction]) -> Void) {
        let endpoint = EthereumEndpoint.getTransactions(block: block)
        etherRpcNetwork.makeAsyncRequest(endpoint) { (result: NetworkResult<RpcEthereumtransactionList>) in
            switch result {
            case .success(let object):
                transactions(object.result.transactions)
            case .failure(let error):
                print(error)
            }
        }
    }
}
