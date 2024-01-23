//
//  ArtistDetail.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/22.
//

import SwiftUI

final class ArtistDetail: LookupDetail, ObservableObject {
    
    let artistId: Int
    let endpoint = "https://itunes.apple.com/lookup?country=tw"
    
    @Published private(set) var musics: [Music] = []
    @Published private(set) var albums: [Album] = []
    
    init(artistId: Int) {
        self.artistId = artistId
        super.init()
        Task {
            do {
                guard let url = URL(string: endpoint + "&entity=song&id=\(artistId)")
                else { throw ApiError.invalidURL }
                
                fetch(Music.self, endpoint: url) { response in
                    switch response {
                        case .success(let musics):
                            self.musics = musics
                            if !self.albums.isEmpty { self.state = .good }
                        case .failure(let error):
                            self.state = .error(error)
                    }
                }
            } catch let error {
                self.state = .error(error)
            }
        }
        Task {
            do {
                guard let url = URL(string: endpoint + "&entity=album&id=\(artistId)")
                else { throw ApiError.invalidURL }
                
                fetch(Album.self, endpoint: url) { response in
                    switch response {
                        case .success(let albums):
                            self.albums = albums
                            if !self.musics.isEmpty { self.state = .good }
                        case .failure(let error):
                            self.state = .error(error)
                    }
                }
            } catch let error {
                self.state = .error(error)
                albums = []
            }
        }
    }
    
}
