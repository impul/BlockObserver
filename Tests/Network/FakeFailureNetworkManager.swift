//
//  FakeFailureNetworkManager.swift
//  Async
//
//  Created by Pavlo Boiko on 3/16/19.
//

@testable import BlockObserver
import XCTest

class FakeFailureNetworkManager: NetworkManagerInterface {
    func makeSyncRequest<SuccessModel: Decodable> (
        _ request: RequestProtocol,
        result: @escaping (NetworkResult<SuccessModel>) -> Void
        ) {
        result(.failure(.unknownError))
    }
    func makeAsyncRequest<SuccessModel: Decodable> (
        _ request: RequestProtocol,
        result: @escaping (NetworkResult<SuccessModel>) -> Void
        ) {
        DispatchQueue.global().async {
            result(.failure(.unknownError))
        }
    }
}
