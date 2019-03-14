//
//  TestHex.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

@testable import BlockObserver
import XCTest

class TestHex: XCTestCase {
    
    func testHexConvert() {
        testNumberForCovert(decimal: 2018, hex: 0x7E2, hexString: "0x7E2", hexStringShort: "7E2")
        testNumberForCovert(decimal: 0, hex: 0x0, hexString: "0x0", hexStringShort: "0")
    }
    
    func testNumberForCovert(decimal: UInt32, hex: UInt32, hexString: String, hexStringShort: String) {
        XCTAssertEqual(decimal.hexString, hexString)
        XCTAssertEqual(hex.hexString, hexString)
        XCTAssertEqual(hexString.hexToInt, decimal)
        XCTAssertEqual(hexStringShort.hexToInt, decimal)
    }
}
