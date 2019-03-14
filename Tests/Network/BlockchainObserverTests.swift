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
    private var blockchainObserver: BlockObserver?
    
    override func setUp() {
        blockchainObserver = BlockObserver(assets: [.ethereum])
    }
    
    func testDefaultEthereumBlockchainObserver() {
        let expectaion = expectation(description: "Get block")
        blockchainObserver?.addObserver(for: "0xBB5933843c4b4Ed2570344B7E1031974E07Ea52c", asset: .ethereum)
        wait(for: [expectaion], timeout: 10)
    }
}
