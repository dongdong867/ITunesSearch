//
//  Artist.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/16.
//

import Foundation
import SwiftSoup

struct Artist: Identifiable, Codable {
    
    let artistLinkUrl: URL
    let artistName: String
    let artistId: Int
    
    var artistAvatarURL: URL?
    
    var id: Int { artistId }
        
    struct ArtistAvatarURL: Codable {
        let image: URL
    }
    
    mutating func setArtistAvatarURL(_ url: URL?) -> Void {
        artistAvatarURL = url
    }
    
    func getArtistURL() async -> URL?  {
        do {
            let html = try String(contentsOf: artistLinkUrl, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            let script = try doc.select("script").first()!.html()
            
            guard let contextJSON = script.data(using: .utf8)
            else {
                throw ApiError.invalidData
            }
            
            let decoder = JSONDecoder()
            return try decoder.decode(ArtistAvatarURL.self, from: contextJSON).image
        } catch {
            return nil
        }
    }
}

extension Artist {
    
    static let sampleData = Artist(
        artistLinkUrl: URL(string: "https://music.apple.com/us/artist/mayday/369211611?uo=4")!,
        artistName: "五月天",
        artistId: 369211611
    )
    
    static let sampleList: [Artist] = [
        Artist(
            artistLinkUrl: URL(string: "https://music.apple.com/us/artist/mayday/369211611?uo=4")!,
            artistName: "五月天",
            artistId: 369211611
        ),
        Artist(
            artistLinkUrl: URL(string: "https://music.apple.com/us/artist/mayday/475649907?uo=4")!,
            artistName: "¡MAYDAY!",
            artistId: 475649907
        ),
        Artist(
            artistLinkUrl: URL(string: "https://music.apple.com/us/artist/mayday-parade/192466619?uo=4")!,
            artistName: "Mayday Parade",
            artistId: 192466619
        )
    ]
}
