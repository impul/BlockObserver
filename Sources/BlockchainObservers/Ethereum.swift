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

}
