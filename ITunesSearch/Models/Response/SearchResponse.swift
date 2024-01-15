//
//  SearchResponse.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/14.
//

import Foundation

struct SearchResponse<T>: Codable where T: Codable {
    
    private enum RootCodingKeys: String, CodingKey {
        case results
    }
    
    private(set) var response: [T] = []
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var responseContainer = try rootContainer.nestedUnkeyedContainer(forKey: .results)
        
        while !responseContainer.isAtEnd {
            response.append(try responseContainer.decode(T.self))
        }
    }
    
}
