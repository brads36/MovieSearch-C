//
//  MovieTableViewController.swift
//  MovieSearch-C
//
//  Created by Bryce Bradshaw on 5/8/20.
//  Copyright © 2020 Bryce Bradshaw. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    // MARK: - Properties
    var movies: [WBBMovie] = []
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell()}

        let movie = self.movies[indexPath.row]
        cell.movie = movie

        return cell
    }

} // End of class

extension MovieTableViewController: UISearchBarDelegate {
     
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        WBBMovieController.fetchMovies(forSearchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .none:
                    print("There was an error when searching for movies.")
                case .some(let movies):
                    self.movies = movies
                    self.tableView.reloadData()
                }
            }
        }
    }
}
