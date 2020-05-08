//
//  MovieTableViewCell.swift
//  MovieSearch-C
//
//  Created by Bryce Bradshaw on 5/8/20.
//  Copyright © 2020 Bryce Bradshaw. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    // MARK: - Properties
    var movie: WBBMovie? {
        didSet {
            updateViewsWithMovie()
        }
    }
    
    func updateViewsWithMovie() {
        if let imagePath = movie?.imagePath {
            WBBMovieController.fetchImage(forImagePath: imagePath) { (results) in
                DispatchQueue.main.async {
                    switch results {
                    case .none:
                        print("Error when Trying to Set Movie cell.")
                    case .some(let image):
                        self.movieImageView.image = image
                    }
                    self.movieTitleLabel.text = self.movie?.title
                    self.movieOverviewLabel.text = self.movie?.overview
                    guard let rating = self.movie?.rating else { return }
                    self.movieRatingLabel.text = "Rating: \(rating)"
                }
            }
        }
    }

}
