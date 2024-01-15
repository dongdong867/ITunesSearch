//
//  SearchState.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/15.
//

import Foundation

enum SearchState: Equatable {
    
    case empty
    case good
    case error(ApiError)
    case loading
    
    static func == (lhs: SearchState, rhs: SearchState) -> Bool {
        lhs.describe() == rhs.describe()
    }
}

extension SearchState {
    func describe() -> String {
        switch self {
            case .empty: return "empty"
            case let .error(error): return error.localizedDescription
            case .good: return "good"
            case .loading: return "loading"
        }
    }
}
