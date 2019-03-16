//
//  Codable+Data.swift
//  Async
//
//  Created by Pavlo Boiko on 3/16/19.
//

import Foundation

extension Encodable {
    public func data(using encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
    public func string(using encoder: JSONEncoder = JSONEncoder()) throws -> String {
        return try String(data: encoder.encode(self), encoding: .utf8)!
    }
}
