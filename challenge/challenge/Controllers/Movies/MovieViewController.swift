//
//  MovieViewController.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/15/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit
import Cosmos

class MovieViewController: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var voteAverage: CosmosView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var overview: UILabel!
//    var movie: Movie?
    var movieId: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIManager.sharedInstance.fetchMovieById(movieId!){ (response) in
            self.movieTitle.text = response!.title
            self.overview.text = response!.overview
            self.voteAverage.rating = Double(response!.voteAverage/2.0)
            if let url = URL(string: response!.posterURL){
                self.movieImage.af_setImage(withURL: url)
            }
        }
    }
}
