//
//  AlbumSearch.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/15.
//

import SwiftUI
import Combine

final class AlbumSearch: ObservableObject {
    
    @Published var result: [Album] = []
    @Published var query: String = ""
    @Published var state: SearchState = .empty
    
    private var querySubscription: AnyCancellable?
    
    init() {
        querySubscription = $query
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .sink { text in
                self.result = []
                if(text.isEmpty) {
                    self.state = .empty
                } else {
                    self.state = .loading
                    self.searchAlbum(by: text)
                }
            }
    }
    
    func searchAlbum(by query: String, page: Int = 1) -> Future<Void, Error> {
        return Future<Void, Error> { [weak self] promise in
            let endpoint = "https://itunes.apple.com/search?term=\(query)&media=music&entity=album&offset=\((page-1)*10)&limit=10"
            
            guard let url = URL(string: endpoint)
            else {
                self?.state = .error(ApiError.invalidURL)
                return promise(.failure(ApiError.invalidURL))
            }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let rawData = try decoder.decode(Response<Album>.self, from: data)
                        
                        self?.result.append(contentsOf: rawData.response)
                        self?.state = .good
                    } catch {
                        self?.state = .error(ApiError.invalidData)
                    }
                } else if let error = error {
                    self?.state = .error(ApiError.unknown(error))
                }
            }.resume()
        }
    }
}

