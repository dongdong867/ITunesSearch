//
//  ReleaseDate.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/15.
//

import Foundation

func getReleaseDate(releaseDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "zh-Hant-CN")
    dateFormatter.dateFormat = "yyyy/MM/dd"
    
    return dateFormatter.string(from: releaseDate)
}

