//
//  Album.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/15.
//

import Foundation

struct Album: Identifiable, Codable {
    
    let artworkUrl100, artistViewUrl, collectionViewUrl: URL
    let collectionId, artistId, trackCount : Int
    let collectionName, artistName, copyright, primaryGenreName: String
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
        trackCount: 30,
        collectionName: "步步自選作品輯 1999-2013",
        artistName: "Mayday",
        copyright: "℗ 2013 Bin Music International Limited",
        primaryGenreName: "國語流行樂",
        releaseDate: try! Date("2013-12-27T08:00:00Z", strategy: .iso8601)
    )
    
    static let sampleList: [Album] = [
        Album(
            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/0b/4d/f0/0b4df092-7531-2d96-0c3f-1f330fd9388e/the_best_of_1999-2013.jpg/100x100bb.jpg")!,
            artistViewUrl: URL(string: "https://music.apple.com/us/artist/mayday/369211611?uo=4")!,
            collectionViewUrl: URL(string: "https://music.apple.com/us/album/%E6%AD%A5%E6%AD%A5%E8%87%AA%E9%81%B8%E4%BD%9C%E5%93%81%E8%BC%AF-1999-2013/1207222248?uo=4")!,
            collectionId: 1207222248,
            artistId: 369211611,
            trackCount: 30,
            collectionName: "步步自選作品輯 1999-2013",
            artistName: "Mayday",
            copyright: "℗ 2013 Bin Music International Limited",
            primaryGenreName: "國語流行樂",
            releaseDate: try! Date("2013-12-27T08:00:00Z", strategy: .iso8601)
        ),
        Album(
            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/64/a0/f1/64a0f1b8-a36b-ff10-509a-9a8f5fef53ff/dj.zfoqlnar.jpg/100x100bb.jpg")!,
            artistViewUrl: URL(string: "https://music.apple.com/us/artist/mayday/369211611?uo=4")!,
            collectionViewUrl: URL(string: "https://music.apple.com/us/album/%E8%87%AA%E5%82%B3/1158763922?uo=4")!,
            collectionId: 1158763922,
            artistId: 369211611,
            trackCount: 15,
            collectionName: "自傳",
            artistName: "Mayday",
            copyright: "℗ 2016 Bin Music International Limited",
            primaryGenreName: "國語流行樂",
            releaseDate: try! Date("2016-07-21T07:00:00Z", strategy: .iso8601)
        ),
        Album(
            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music123/v4/23/c0/ad/23c0adfa-c8e3-02b4-d2e6-6a3a2da770d6/1.5.jpg/100x100bb.jpg")!,
            artistViewUrl: URL(string: "https://music.apple.com/tw/artist/%E4%BA%94%E6%9C%88%E5%A4%A9/369211611?uo=4")!,
            collectionViewUrl: URL(string: "https://music.apple.com/tw/album/%E4%BA%94%E6%9C%88%E5%A4%A9-%E4%BA%BA%E7%94%9F%E7%84%A1%E9%99%90%E5%85%AC%E5%8F%B8-life-live-%E5%AE%8C%E6%95%B4%E6%94%B6%E9%8C%84%E7%AF%87/1464877093?uo=4")!,
            collectionId: 1464877093,
            artistId: 369211611,
            trackCount: 24,
            collectionName: "五月天 人生無限公司 Life Live 完整收錄篇",
            artistName: "五月天",
            copyright: "℗ 2019 Bin Music International Limited",
            primaryGenreName: "國語流行樂",
            releaseDate: try! Date("2019-05-23T07:00:00Z", strategy: .iso8601)
        )
    ]
}
