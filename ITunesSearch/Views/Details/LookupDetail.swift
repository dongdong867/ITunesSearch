//
//  LookupDetail.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/23.
//

import Foundation

class LookupDetail {
    
    internal var state: LookupDetailState = .loading
    
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
    
    enum LookupDetailState {
        case loading
        case good
        case error(Error)
    }
    
}
