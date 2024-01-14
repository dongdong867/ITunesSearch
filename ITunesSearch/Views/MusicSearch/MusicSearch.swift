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
            .sink { print($0) }
    }
}
