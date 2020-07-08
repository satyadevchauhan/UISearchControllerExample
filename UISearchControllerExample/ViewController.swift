//
//  ViewController.swift
//  UISearchControllerExample
//
//  Created by Satyadev Chauhan on 08/07/20.
//  Copyright © 2020 Satyadev Chauhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellIdentifier = "cell"
    var filteredFootBallPlayer = [Player]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Players"
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func filterFootballers(for searchText: String) {
        filteredFootBallPlayer = FootBallPlayers.filter { player in
            return player.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}

// MARK:- UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredFootBallPlayer.count
        }
        return FootBallPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let player: Player
        if searchController.isActive && searchController.searchBar.text != "" {
            player = filteredFootBallPlayer[indexPath.row]
        } else {
            player = FootBallPlayers[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = player.name
        cell.detailTextLabel?.text = player.league
        return cell
    }
}

// MARK:- UISearchResultsUpdating

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterFootballers(for: searchController.searchBar.text ?? "")
    }
}

