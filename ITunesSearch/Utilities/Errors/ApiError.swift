//
//  ApiError.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/14.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unknown(Error)
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .invalidData:
                return NSLocalizedString("Received unexpected data format.", comment: "DataFetchingError")
            case .invalidResponse:
                return NSLocalizedString("Received response code out of range 200-299.", comment: "ResponseCodeError")
            case .invalidURL:
                return NSLocalizedString("Received endpoint is not an url.", comment: "InvalidURLError")
            case let .unknown(error):
                return NSLocalizedString("Error unknown happened. Error message: \(error)", comment: "UnknownError")
        }
    }
}
