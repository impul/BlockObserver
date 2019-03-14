//
//  NetworkError.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

public enum NetworkError: Error, Decodable {
    case error(ErrorMessage)
    case unknownError
    case defaultError(Error)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            let leftValue = try container.decode(String.self, forKey: .error)
            self = .error(ErrorMessage(error: leftValue))
        } catch {
            self = .unknownError
        }
    }
    
    enum CodingKeys: CodingKey {
        case unknownError, error
    }
    
    public var localizedDescription: String {
        switch self {
        case .unknownError:
            return "Unknows error"
        case .error(let message):
            return message.error
        case .defaultError(let error):
            return error.localizedDescription
        }
    }
}
