//
//  Ethereum.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

fileprivate enum Defaults {
    static var updateIntervat: TimeInterval = 5
}

internal class EthereumBlockchainObserver: DefaultBlockchainObserver {
    override var asset: Asset { return .ethereum }
    private let etherRpcNetwork: NetworkManagerInterface
    private let observeQueue: DispatchQueue
    private var observeTimer: Timer?
    
    required init(delegate: BlockchainObserverDelegate) {
        let rpcUrl = Asset.ethereum.rpcUrl
        etherRpcNetwork = NetworkManager(rpcUrl)
        observeQueue = DispatchQueue(label: rpcUrl)
        super.init(delegate: delegate)
        observeTimer = Timer(timeInterval: Defaults.updateIntervat, repeats: true, block: checkUpdate)
        observeTimer?.fire()
    }
    
    private lazy var checkUpdate: (Timer) -> Void = { _ in
        self.etherRpcNetwork.makeAsyncRequest(EthereumEndpoint.getCurrentBlock) { (result: NetworkResult<CurrentBlock>) in
            switch result {
            case .success(let object):
                print(object.result)
            case .failure(let error):
                print(error)
            }
        }
    }
}
