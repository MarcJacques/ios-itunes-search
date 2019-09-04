//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Marc Jacques on 9/3/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import Foundation

class SearchResultsController {
    
    let baseURL = URL(string: "https://itunes.apple.com/")!
    
    var searchResult = [SearchResult]()
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        let fullRequestURL = baseURL.appendingPathComponent("search")
        var components = URLComponents(url: fullRequestURL, resolvingAgainstBaseURL: true)
        let searchItem = URLQueryItem(name: "term", value: searchTerm)
        let entityItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        components?.queryItems = [searchItem, entityItem]
        
        guard let requestURL = components?.url else {
            NSLog("Request URL is nil")
            completion(NSError())
            return
      }
//        print(requestURL)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            //check for error
            if let error = error {
                NSLog(error.localizedDescription)
                completion(error)
            }
            //check for data
            guard let data = data else {
                NSLog("Error getting data.")
                return
            }
            //decode data
            do {
                let decoder = JSONDecoder()
                let fileSearch = try decoder.decode(SearchResults.self, from: data)
                
                self.searchResult = fileSearch.results
                completion(nil)
            } catch {
                NSLog(error.localizedDescription)
                completion(error)
            }
            
        }.resume()
    }
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
}
