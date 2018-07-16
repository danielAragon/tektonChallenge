//
//  Movie.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/13/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import Foundation

class MoviesApiResponse{
    var movies: [Movie]!

    init(_ json: [String:Any]){
        movies = [Movie]()
        for movie in json["results"] as! NSArray{
            movies?.append(Movie(movie as! [String : Any]))
            
        }
    }
}

class Movie {
    var id: Int!
    var title: String!
    var overview: String!
    var posterURL: String!
    var budget: String?
    var voteAverage : Float!
    
    init(_ json: [String:Any]){
        self.id = json["id"] as! Int
        self.title = json["title"] as! String
        self.overview = json["overview"] as! String
        self.posterURL = APIManager.APIImage + "\(json["poster_path"] as! String)"
        self.budget = json["budget"] as? String
        self.voteAverage = (json["vote_average"] as! NSNumber).floatValue
    }
}
