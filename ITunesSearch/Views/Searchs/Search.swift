//
//  Search.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/16.
//

import SwiftUI
import Combine

class Search<T> where T: Codable {
    
    @Published private(set) var result: [T] = []
    @Published private(set) var state: SearchState = .empty
    
    func search(
        with endpoint: String,
        by query: String,
        from page: Int = 1
    ) -> Future<Void, Error> {
        return Future<Void, Error> { [weak self] promise in
            guard let url = URL(string: endpoint + "&term=\(query)&offset=\((page-1)*10)")
            else {
                self?.state = .error(ApiError.invalidURL)
                return promise(.failure(ApiError.invalidURL))
            }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let response = response as? HTTPURLResponse,
                      200...299 ~= response.statusCode
                else {
                    self?.state = .error(ApiError.invalidResponse)
                    return promise(.failure(ApiError.invalidResponse))
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let rawData = try decoder.decode(Response<T>.self, from: data)
                        
                        self?.result.append(contentsOf: rawData.response)
                        self?.state = .good
                    } catch {
                        self?.state = .error(ApiError.invalidData)
                        return promise(.failure(ApiError.invalidData))
                    }
                } else if let error = error {
                    self?.state = .error(ApiError.unknown(error))
                }
            }.resume()
        }
    }
    
    func clearResult() -> Void {
        result = []
    }
    
    func setState(_ state: SearchState) -> Void {
        self.state = state
    }
}
