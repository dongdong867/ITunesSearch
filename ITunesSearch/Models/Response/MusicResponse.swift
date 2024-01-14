//
//  MusicResponse.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/14.
//

import Foundation

struct MusicResponse: Codable {
    
    private enum RootCodingKeys: String, CodingKey {
        case results
    }
    
    private(set) var musics: [Music] = []
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var musicsContainer = try rootContainer.nestedUnkeyedContainer(forKey: .results)
        
        while !musicsContainer.isAtEnd {
            musics.append(try musicsContainer.decode(Music.self))
        }
    }
    
}
