//
//  MusicSearch.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/14.
//

import SwiftUI
import Combine

final class MusicSearch: ObservableObject {
    @Published var result: [Music] = []
    @Published var query: String = ""
    
    private var querySubscription: AnyCancellable?
    
    init() {
        querySubscription = $query
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .sink { [weak self] text in
                if(!text.isEmpty) {
                    self?.result = []
                    self?.searchMusic(by: text)
                }
            }
    }
    
    func searchMusic(by query: String, page: Int = 1) -> Future<Void, Error> {
        return Future<Void, Error> { [weak self] promise in
            let endpoint = "https://itunes.apple.com/search?term=\(query)&media=music&offset=\((page-1)*10)&limit=\(page*10)"
            
            guard let url = URL(string: endpoint) else {
                return promise(.failure(ApiError.invalidURL))
            }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let rawData = try decoder.decode(MusicResponse.self, from: data)
                        self?.result.append(contentsOf: rawData.musics)
                    } catch {
                        print("invalid data")
                    }
                } else if let error = error {
                    print(error)
                }
            }.resume()
                
        }
    }
    
}
