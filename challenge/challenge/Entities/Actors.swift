//
//  Actors.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/15/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import Foundation

class ActorsApiResponse{
    var actors: [Actor]!
    
    init(_ json: [String:Any]){
        actors = [Actor]()
        for actor in json["results"] as! NSArray{
            actors?.append(Actor(actor as! [String : Any]))
        }
    }
}

class Actor {
    var id: Int!
    var name: String!
    var plays: [Play]!
    var profileURL: String!
    
    init(_ json: [String:Any]){
        self.id = json["id"] as! Int
        self.name = json["name"] as! String
        
        if let json = json["known_for"]{
            plays = [Play]()
            for play in json as! NSArray{
                plays.append(Play(play as! [String : Any]))
            }
        }
        
        self.profileURL = APIManager.APIImage + "\(json["profile_path"] as! String)"
    }
}

class Play{
    var appellation: String!
    init(_ json: [String:Any]){
        if let title = json["title"]{
            self.appellation = title as! String
        }else if let name = json["name"]{
            self.appellation = name as! String
        }else{
            self.appellation = ""
        }
    }
}
