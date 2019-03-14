//
//  RPC2RequestsTests.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//


@testable import BlockObserver
import XCTest

struct TestRpcEndpoint: RPC2RequestProtocol {
    var rpcMethod: String
    var rpcId: Int
    var rpcParametrs: [Any]
    
    init(rpcMethod: String, rpcId: Int, rpcParametrs: [Any]) {
        self.rpcMethod = rpcMethod
        self.rpcId = rpcId
        self.rpcParametrs = rpcParametrs
    }
}

fileprivate enum Constants {
    static var method = "first"
    static var rpcId = 0
    static var rpcParametrs = [["test": "test", "test1": "test1"]]
    static var url = "https://test.com"
}


class RPC2RequestsTests: XCTestCase {
    func defaultRequest() -> RequestProtocol {
        return TestRpcEndpoint(rpcMethod: Constants.method, rpcId: Constants.rpcId, rpcParametrs: Constants.rpcParametrs)
    }
    
    func testRpc2RequestProtocolDefaultPrametrs() {
        let request = defaultRequest()
        let parametrs = request.parameters!
        XCTAssertEqual(parametrs["jsonrpc"] as! String, "2.0")
        XCTAssertEqual(parametrs["id"] as! Int, Constants.rpcId)
        XCTAssertEqual(parametrs["method"] as! String, Constants.method)
        XCTAssertEqual(parametrs["params"] as! [[String:String]], Constants.rpcParametrs)
    }
    
    func testRpc2RequestBuildedToNURLRequesData() {
        let requestBuilder = RequestBuilder(request: defaultRequest())
        let urlRequest = requestBuilder.build(for: Constants.url)
        let json = try! JSONSerialization.jsonObject(with: urlRequest.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertEqual(json["jsonrpc"] as! String, "2.0")
        XCTAssertEqual(json["id"] as! Int, Constants.rpcId)
        XCTAssertEqual(json["method"] as! String, Constants.method)
        XCTAssertEqual(json["params"] as! [[String:String]], Constants.rpcParametrs)
    }
}
