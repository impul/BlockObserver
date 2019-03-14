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
        blockchainObserver?.addObserver(for: "0x131a99859a8bfa3251d899f0675607766736ffae", asset: .ethereum)
        wait(for: [expectaion], timeout: 100)
    }
}
