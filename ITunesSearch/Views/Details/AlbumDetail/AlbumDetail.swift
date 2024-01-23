//
//  AlbumDetail.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/23.
//

import Foundation

final class AlbumDetail: LookupDetail, ObservableObject {
    
    let albumId: Int
    let endpoint = "https://itunes.apple.com/lookup?entity=song&country=tw"
    
    @Published var tracks: [Music] = []
    
    init(albumId: Int) {
        self.albumId = albumId
        super.init()
        Task {
            do {
                guard let url = URL(string: endpoint + "&id=\(albumId)")
                else { throw ApiError.invalidURL }
                
                fetch(Music.self, endpoint: url) { response in
                    switch response {
                        case .success(let tracks):
                            self.tracks = tracks
                            self.state = .good
                        case .failure(let error):
                            self.state = .error(error)
                    }
                }
            } catch let error {
                self.state = .error(error)
            }
        }
    }
    
}
