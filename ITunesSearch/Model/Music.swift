//
//  Music.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/12.
//

import Foundation

struct Music: Identifiable, Codable {
    
    let artworkUrl100, artistViewUrl, collectionViewUrl, previewUrl: URL
    let trackId, collectionId, artistId: Int
    let trackName, collectionName, artistName: String
    let releaseDate: String
    
    var id: Int { trackId }
    
}

