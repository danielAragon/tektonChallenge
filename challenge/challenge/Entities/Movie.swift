//
//  Movie.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/13/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import Foundation

class MovieApiResponse{
    var page: Int!
    var movies: [Movie]!

    init(_ Dict: [String:Any]){
        self.page = Dict["page"] as! Int
        
        movies = [Movie]()
        for movie in Dict["results"] as! NSArray{
            movies?.append(Movie(movie as! [String : Any]))
        }
    }
}

class Movie {
    var title: String!
    var overview: String!
    
    init(_ Dict: [String:Any]){
        self.title = Dict["title"] as! String
        self.overview = Dict["overview"] as! String
    }
}
