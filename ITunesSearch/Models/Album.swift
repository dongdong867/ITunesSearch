//
//  Album.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/15.
//

import Foundation

struct Album: Identifiable, Codable {
    
    let artworkUrl100, artistViewUrl, collectionViewUrl: URL
    let collectionId, artistId : Int
    let collectionName, artistName: String
    let releaseDate: Date
    
    var id: Int { collectionId }
}

extension Album {
    
    static let sampleData = Album(
        artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/0b/4d/f0/0b4df092-7531-2d96-0c3f-1f330fd9388e/the_best_of_1999-2013.jpg/100x100bb.jpg")!,
        artistViewUrl: URL(string: "https://music.apple.com/us/artist/mayday/369211611?uo=4")!,
        collectionViewUrl: URL(string: "https://music.apple.com/us/album/%E6%AD%A5%E6%AD%A5%E8%87%AA%E9%81%B8%E4%BD%9C%E5%93%81%E8%BC%AF-1999-2013/1207222248?uo=4")!,
        collectionId: 1207222248,
        artistId: 369211611,
        collectionName: "步步自選作品輯 1999-2013",
        artistName: "Mayday",
        releaseDate: try! Date("2013-12-27T08:00:00Z", strategy: .iso8601)
    )
    
    static let sampleList: [Album] = [
        Album(
            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/0b/4d/f0/0b4df092-7531-2d96-0c3f-1f330fd9388e/the_best_of_1999-2013.jpg/100x100bb.jpg")!,
            artistViewUrl: URL(string: "https://music.apple.com/us/artist/mayday/369211611?uo=4")!,
            collectionViewUrl: URL(string: "https://music.apple.com/us/album/%E6%AD%A5%E6%AD%A5%E8%87%AA%E9%81%B8%E4%BD%9C%E5%93%81%E8%BC%AF-1999-2013/1207222248?uo=4")!,
            collectionId: 1207222248,
            artistId: 369211611,
            collectionName: "步步自選作品輯 1999-2013",
            artistName: "Mayday",
            releaseDate: try! Date("2013-12-27T08:00:00Z", strategy: .iso8601)
        ),
        Album(
            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/64/a0/f1/64a0f1b8-a36b-ff10-509a-9a8f5fef53ff/dj.zfoqlnar.jpg/100x100bb.jpg")!,
            artistViewUrl: URL(string: "https://music.apple.com/us/artist/mayday/369211611?uo=4")!,
            collectionViewUrl: URL(string: "https://music.apple.com/us/album/%E8%87%AA%E5%82%B3/1158763922?uo=4")!,
            collectionId: 1158763922,
            artistId: 369211611,
            collectionName: "自傳",
            artistName: "Mayday",
            releaseDate: try! Date("2016-07-21T07:00:00Z", strategy: .iso8601)
        ),
        Album(
            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music4/v4/d0/72/c1/d072c160-da8e-e170-aa95-3f7e43f5c0b2/853435003579_Cover.jpg/100x100bb.jpg")!,
            artistViewUrl: URL(string: "https://music.apple.com/us/artist/mayday/475649907?uo=4")!,
            collectionViewUrl: URL(string: "https://music.apple.com/us/album/mursday-deluxe-edition/874193035?uo=4")!,
            collectionId: 874193035,
            artistId: 475649907,
            collectionName: "Mursday (Deluxe Edition)",
            artistName: "¡MAYDAY! & Murs",
            releaseDate: try! Date("2014-06-10T07:00:00Z", strategy: .iso8601)
        )
    ]
}
