//
//  FakeSuccessNetworkManager.swift
//  Async
//
//  Created by Pavlo Boiko on 3/16/19.
//

@testable import BlockObserver
import XCTest

class FakeSuccessNetworkManager: NetworkManagerInterface {
    let modelData: Data
    init(model: Data) {
        modelData = model
    }
    func makeSyncRequest<SuccessModel: Decodable> (
        _ request: RequestProtocol,
        result: @escaping (NetworkResult<SuccessModel>) -> Void
        ) {
        let object = try! JSONDecoder().decode(SuccessModel.self, from: self.modelData)
        result(.success(object))
    }
    func makeAsyncRequest<SuccessModel: Decodable> (
        _ request: RequestProtocol,
        result: @escaping (NetworkResult<SuccessModel>) -> Void
        ) {
        DispatchQueue.global().async {
            self.makeSyncRequest(request, result: result)
        }
    }
}
