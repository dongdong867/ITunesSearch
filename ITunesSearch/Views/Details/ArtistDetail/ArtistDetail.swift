//
//  ArtistDetail.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/22.
//

import SwiftUI

final class ArtistDetail: ObservableObject {
    let artistId: Int
    let endpoint: String
    var state: ArtistDetailState = .loading
    
    @Published private(set) var musics: [Music] = []
    @Published private(set) var albums: [Album] = []
    
    init(artistId: Int) {
        self.artistId = artistId
        self.endpoint = "https://itunes.apple.com/lookup?country=tw&id=\(artistId)"
        Task {
            do {
                guard let url = URL(string: endpoint + "&entity=song")
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
                guard let url = URL(string: endpoint + "&entity=album")
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
    
    func getState() -> String {
        switch state {
            case .loading:
                return "loading"
            case .good:
                return "good"
            case .error(let error):
                return "error"
        }
    }
    
    func fetch<T>(
        _ type: T.Type,
        endpoint: URL,
        completion: @escaping (Result<[T], Error>) -> Void
    ) -> Void where T: Codable {
        URLSession.shared.dataTask(with: endpoint) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode
            else {
                completion(.failure(ApiError.invalidResponse))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let rawData = try decoder.decode(LookupResponse<T>.self, from: data)
                    
                    completion(.success(rawData.response))
                } catch let error {
                    completion(.failure(error))
                    return
                }
            }
        }.resume()
    }

    
    enum ArtistDetailState {
        case loading
        case good
        case error(Error)
    }
}
