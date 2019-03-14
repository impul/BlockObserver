//
//  BlockchainObserverTests.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

@testable import BlockObserver
import XCTest


class BlockchainObserverTests: XCTestCase {

    func testDefaultEthereumBlockchainObserver() {
        let ethereumMiddlware = EthereumMiddleware(url: "testUrl")
    }
}
