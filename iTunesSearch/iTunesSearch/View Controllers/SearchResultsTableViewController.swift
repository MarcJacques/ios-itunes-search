//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Marc Jacques on 9/3/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResultsController = SearchResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        
        let result = searchResultsController.searchResult[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator
        
        return cell
    }
    // Mark: Helpers
    
    private func searching() {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                return ResultType.app
            case 1:
                return ResultType.music
            default:
                return ResultType.movie
            }
        }
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Search failed. \(error)")
                return 
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searching()
    }
}
