//
//  RippleMiddleware.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

fileprivate var rippleRestUrl = "https://data.ripple.com/v2/"

public class RippleMiddleware: RippleMiddlewareInterface {
    private let rippleRpcNetwork: NetworkManagerInterface
    private let rippleRestNetwork: NetworkManagerInterface
    
    public init(url: String) {
        rippleRpcNetwork = NetworkManager(url)
        rippleRestNetwork = NetworkManager(rippleRestUrl)
    }
    
    public func getLastBlockNumber(lastBlock: @escaping (UInt64) -> Void) {
        rippleRpcNetwork.makeAsyncRequest(RippleRpcEndpoint.getCurrentBlock) { (result: NetworkResult<RippleBlockNumberResponce>) in
            switch result {
            case .success(let object):
                lastBlock(object.result.ledger_index)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getTransactionInBlockRange(byBlock: UInt64, transactions: @escaping ([RippleTransaction]) -> Void) {
        let endpoint = RippleRestEndpoint.getTransaction(inBlock: byBlock)
        rippleRestNetwork.makeAsyncRequest(endpoint) { (result: NetworkResult<RippleTransactionsResult>) in
            switch result {
            case .success(let object):
                transactions(object.ledger.transactions)
            case .failure(let error):
                print(error)
            }
        }
    }
}
