//
//  LookupResponse.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/23.
//

import Foundation

struct LookupResponse<T>: Codable where T: Codable {
    
    private enum RootCodingKeys: String, CodingKey {
        case results
    }
    
    private struct ResultCodingKeys: Codable {
        let wrapperType: String
    }
    
    private(set) var response: [T] = []
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var responseContainer = try rootContainer.nestedUnkeyedContainer(forKey: .results)
        _ = try responseContainer.decode(ResultCodingKeys.self)

        while !responseContainer.isAtEnd {
            response.append(try responseContainer.decode(T.self))
        }
    }
    
}
