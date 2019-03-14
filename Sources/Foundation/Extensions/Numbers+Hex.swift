//
//  Numbers+Hex.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

extension UInt32 {
    public var hexString: String {
        return String(self, radix: 16, uppercase: true).addHexPrefix
    }
}

extension String {
    public var hexToInt: UInt32 {
        let hex = self.hasPrefix("0x") ? String(self.dropFirst(2)) : self
        return UInt32(hex, radix: 16) ?? 0
    }
    
    public var addHexPrefix: String {
        return "0x" + self
    }
}
