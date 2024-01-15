//
//  MusicSearch.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/14.
//

import SwiftUI
import Combine

final class MusicSearch: Search<Music>, ObservableObject {
    
    @Published var query: String = ""
    
    private var querySubscription: AnyCancellable?
    private var endpoint = "https://itunes.apple.com/search?&media=music&limit=10"
    
    override init() {
        super.init()
        querySubscription = $query
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .sink { text in
                if(!text.isEmpty) {
                    self.clearResult()
                    self.setState(.loading)
                    self.search(with: self.endpoint, by: self.query)
                } else {
                    self.clearResult()
                    self.setState(.empty)
                }
            }
    }
    
}
