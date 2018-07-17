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

    required init(_ json: [String:Any]){
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
    var budget: Int?
    var voteAverage : Float!
    var homepage: String?
    
    init(_ json: [String:Any]){
        self.id = json["id"] as! Int
        self.title = json["title"] as! String
        self.homepage = json["homepage"] as? String
        self.overview = json["overview"] as! String
        self.posterURL = APIManager.APIImage + "\(json["poster_path"] as! String)"
        self.budget = json["budget"] as? Int
        self.voteAverage = (json["vote_average"] as! NSNumber).floatValue
    }
}
