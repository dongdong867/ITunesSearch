//
//  AlbumSearch.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/15.
//

import SwiftUI
import Combine

final class AlbumSearch: Search<Album>, ObservableObject {
    
    @Published var query: String = ""
    
    private var querySubscription: AnyCancellable?
    private let endpoint = "https://itunes.apple.com/search?media=music&entity=album&country=tw&limit=10"
    
    override init() {
        super.init()
        querySubscription = $query
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .sink { text in
                self.clearResult()
                if(text.isEmpty) {
                    self.setState(.empty)
                } else {
                    self.setState(.loading)
                    self.search(with: self.endpoint, by: self.query)
                }
            }
    }
    
}

