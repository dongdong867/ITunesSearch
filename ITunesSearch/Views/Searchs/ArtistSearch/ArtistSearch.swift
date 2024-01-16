//
//  ArtistSearch.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/16.
//

import SwiftUI
import Combine

final class ArtistSearch: Search<Artist>, ObservableObject {
    
    @Published var query: String = ""
    
    private var querySubscription: AnyCancellable?
    private let endpoint = "https://itunes.apple.com/search?media=music&entity=allArtist&limit=10"
    
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
