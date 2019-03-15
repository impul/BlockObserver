//
//  NetworkManager.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public class NetworkManager: NetworkManagerInterface {
    private var urlSession: URLSession
    
    public init(_ url: String) {
        self.url = url
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        config.allowsCellularAccess = true
        if #available(iOS 11, OSX 10.13, *) {
            config.waitsForConnectivity = true
        }
        urlSession = URLSession(configuration: config)
    }
    
    let url: String
    
    public func makeAsyncRequest<SuccessModel: Decodable> (
        _ request: RequestProtocol,
        result: @escaping (NetworkResult<SuccessModel>) -> Void
        ) {
        DispatchQueue.global().async {
            self.makeSyncRequest(request, result: result)
        }
    }
    
    public func makeSyncRequest<SuccessModel: Decodable> (
        _ request: RequestProtocol,
        result: @escaping (NetworkResult<SuccessModel>) -> Void
        ) {
        makeRequest(request) { (data, error) in
            self.handleResponse(response: (data, error), result: result)
        }
    }
    
    public func makeRequest(_ request: RequestProtocol, result: @escaping (Data?, Error?) -> Void) {
        let requestBuilder = RequestBuilder(request: request)
        let urlRequest = requestBuilder.build(for: url)
        switch request.contentType {
        case .json:
            urlSession.dataTask(with: urlRequest) { (data, _, error) in
                result(data, error)
                }.resume()
        }
    }
    
    private func handleResponse<SuccessModel: Decodable> (
        response: (Data?, Error?),
        result: @escaping (NetworkResult<SuccessModel>) -> Void
        ) {
        guard let data = response.0 else {
            guard let error = response.1 else {
                result(.failure(.unknownError))
                return
            }
            result(.failure(NetworkError.defaultError(error)))
            return
        }
        guard let object = try? JSONDecoder().decode(SuccessModel.self, from: data) else {
            self.handleError(response: data, result: result)
            return
        }
        result(.success(object))
    }
    
    private func handleError<SuccessModel: Decodable> (
        response: Data,
        result: @escaping (NetworkResult<SuccessModel>) -> Void
        ) {
        let decoder = JSONDecoder()
        guard let failedObject = try? decoder.decode(NetworkError.self, from: response) else {
            result(.failure(.unknownError))
            return
        }
        result(.failure(failedObject))
    }
}
