//
//  Series.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/15/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import Foundation

class SeriesApiResponse{
    var series: [Serie]!
    
    init(_ json: [String:Any]){
        series = [Serie]()
        for serie in json["results"] as! NSArray{
            series?.append(Serie(serie as! [String : Any]))
        }
    }
}

class Serie {
    var id: Int!
    var name: String!
    var overview: String!
    var posterURL: String!
    
    init(_ json: [String:Any]){
        self.id = json["id"] as! Int
        self.name = json["original_name"] as! String
        self.overview = json["overview"] as! String
        self.posterURL = "https://image.tmdb.org/t/p/w500\(json["poster_path"] as! String)"
    }
}
