//
//  RequestProtocol.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public typealias HTTPHeader = [String: String]
public typealias HTTParametrs = [String: Any]

fileprivate enum Constants {
    static var jsonContentType = "application/json"
}

public enum NetworkResult<Object: Decodable> {
    case success(Object)
    case failure(NetworkError)
}

public enum RequestType {
    case post, get
    public var description: String {
        return String(describing: self).uppercased()
    }
}

public enum RequestContentType {
    case json
    public var description: String {
        switch self {
        case .json:
            return Constants.jsonContentType
        }
    }
}

public protocol RequestProtocol {
    var path: String { get }
    var extraHeaders: HTTPHeader? { get }
    var parameters: HTTParametrs? { get }
    var requestType: RequestType { get }
    var contentType: RequestContentType { get }
}
