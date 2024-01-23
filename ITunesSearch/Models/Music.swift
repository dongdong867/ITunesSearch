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
    let releaseDate: Date
    
    var id: Int { trackId }
}


extension Music {
    
    static var sampleData: Music {
        Music(
            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/64/a0/f1/64a0f1b8-a36b-ff10-509a-9a8f5fef53ff/dj.zfoqlnar.jpg/100x100bb.jpg")!,
            artistViewUrl: URL(string: "https://music.apple.com/us/artist/mayday/369211611?uo=4")!,
            collectionViewUrl: URL(string: "https://music.apple.com/us/album/%E5%BE%8C%E4%BE%86%E7%9A%84%E6%88%91%E5%80%91/1158763922?i=1158763996&uo=4")!,
            previewUrl: URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/91/30/64/9130646e-c52a-5b50-b472-a0614c583da2/mzaf_10722775092036331265.plus.aac.p.m4a")!,
            trackId: 1158763996,
            collectionId: 1158763922,
            artistId: 369211611,
            trackName: "後來的我們",
            collectionName: "自傳",
            artistName: "Mayday",
            releaseDate: try! Date("2016-07-21T07:00:00Z", strategy: .iso8601)
        )
    }
    
    static var sampleList: [Music] {
    [
        Music(
            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/64/a0/f1/64a0f1b8-a36b-ff10-509a-9a8f5fef53ff/dj.zfoqlnar.jpg/100x100bb.jpg")!,
            artistViewUrl: URL(string: "https://music.apple.com/us/artist/mayday/369211611?uo=4")!,
            collectionViewUrl: URL(string: "https://music.apple.com/us/album/%E5%BE%8C%E4%BE%86%E7%9A%84%E6%88%91%E5%80%91/1158763922?i=1158763996&uo=4")!,
            previewUrl: URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/91/30/64/9130646e-c52a-5b50-b472-a0614c583da2/mzaf_10722775092036331265.plus.aac.p.m4a")!,
            trackId: 1158763996,
            collectionId: 1158763922,
            artistId: 369211611,
            trackName: "後來的我們",
            collectionName: "自傳",
            artistName: "Mayday",
            releaseDate: try! Date("2016-07-21T07:00:00Z", strategy: .iso8601)
        ),
        Music(
            artworkUrl100: URL(string:"https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/64/a0/f1/64a0f1b8-a36b-ff10-509a-9a8f5fef53ff/dj.zfoqlnar.jpg/100x100bb.jpg")!,
            artistViewUrl: URL(string: "https://music.apple.com/us/artist/mayday/369211611?uo=4")!,
            collectionViewUrl: URL(string: "https://music.apple.com/us/album/%E6%B4%BE%E5%B0%8D%E5%8B%95%E7%89%A9/1158763922?i=1158763998&uo=4")!,
            previewUrl: URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/05/2e/a5/052ea500-fba0-62ed-9a34-9dbb4ffcee44/mzaf_16014584755230246981.plus.aac.p.m4a")!,
            trackId: 1158763998,
            collectionId: 1158763922,
            artistId: 369211611,
            trackName: "派對動物",
            collectionName: "自傳",
            artistName: "Mayday",
            releaseDate: try! Date("2016-05-20T07:00:00Z", strategy: .iso8601)
        ),
        Music(
            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/64/a0/f1/64a0f1b8-a36b-ff10-509a-9a8f5fef53ff/dj.zfoqlnar.jpg/100x100bb.jpg")!,
            artistViewUrl: URL(string: "https://music.apple.com/us/artist/mayday/369211611?uo=4")!,
            collectionViewUrl: URL(string: "https://music.apple.com/us/album/%E5%A6%82%E6%9E%9C%E6%88%91%E5%80%91%E4%B8%8D%E6%9B%BE%E7%9B%B8%E9%81%87/1158763922?i=1158763991&uo=4")!,
            previewUrl: URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/fb/55/e9/fb55e9de-75d3-c063-17b5-282a5f99e465/mzaf_11290185213379127515.plus.aac.p.m4a")!,
            trackId: 1158763991,
            collectionId: 1158763922,
            artistId: 369211611,
            trackName: "如果我們不曾相遇",
            collectionName: "自傳",
            artistName: "Mayday",
            releaseDate: try! Date("2016-06-22T07:00:00Z", strategy: .iso8601)
        )
    ]
}
    
}
