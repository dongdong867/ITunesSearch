//
//  SearchState.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/15.
//

import Foundation

enum SearchState {
    case empty
    case good
    case error(Error)
    case loading
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
