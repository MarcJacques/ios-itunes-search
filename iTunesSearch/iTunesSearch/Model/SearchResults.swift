//
//  SearchResults.swift
//  iTunesSearch
//
//  Created by Marc Jacques on 9/3/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    
    enum codingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        //https://itunes.apple.com/search?term=yelp&entity=software
    }
}

struct SearchResults: Codable {
    
    let results: [SearchResult]
}
