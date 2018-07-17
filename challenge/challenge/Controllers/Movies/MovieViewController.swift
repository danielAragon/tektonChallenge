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
    @IBOutlet weak var budget: UILabel!
    
    var movieId: Int!
    var movieHomePage: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIManager.sharedInstance.fetchMovieById(movieId!){ (response) in
            self.movieTitle.text = response!.title
            self.overview.text = response!.overview
            self.voteAverage.rating = Double(response!.voteAverage/2.0)
            self.budget.text = "Budget: \(response!.budget!)"
            self.movieHomePage = response!.homepage ?? nil
            if let url = URL(string: response!.posterURL){
                self.movieImage.af_setImage(withURL: url)
            }
        }
    }
    @IBAction func share(_ sender: Any) {
        var message: String
        if let _message = self.movieHomePage{
            message = "Hey! checkout \(_message)"
        }else{
            message = "Hey! checkout https://www.themoviedb.org"
        }
        let activityVC = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    @IBAction func goBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
