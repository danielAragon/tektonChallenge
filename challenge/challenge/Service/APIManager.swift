//
//  APIManager.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/13/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import Foundation
import Alamofire

public struct APIManager{
    
    static let sharedInstance = APIManager()
    static let APIImage = "https://image.tmdb.org/t/p/w500"
    
    let APIBase = "https://api.themoviedb.org/3"
    let APIKey = "?api_key=07db23794cd348240def66ce0def1c34"

    func fetchMovies(_ page: String, handler: @escaping (MoviesApiResponse?) -> Void) {
        
        let host = APIBase + "/movie/popular" + APIKey + "&page=\(page)"
        
        Alamofire.request(host, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                case .success(_):
                    handler(MoviesApiResponse((response.value as? [String: Any])!))
                case .failure(_):
                    break
                }

        }
    }
    func fetchSeries(_ page: String, handler: @escaping (SeriesApiResponse?) -> Void) {
        
        let host = APIBase + "/tv/popular" + APIKey + "&page=\(page)"
        
        Alamofire.request(host, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                case .success(_):
                    handler(SeriesApiResponse((response.value as? [String: Any])!))
                case .failure(_):
                    break
                }
                
        }
    }
    func fetchActors(_ page: String, handler: @escaping (ActorsApiResponse?) -> Void) {
        
        let host = APIBase + "/person/popular" + APIKey + "&page=\(page)"
        
        Alamofire.request(host, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                case .success(_):
                    handler(ActorsApiResponse((response.value as? [String: Any])!))
                case .failure(_):
                    break
                }
        }
    }
    
    func fetchMovieById(_ id: Int,handler: @escaping (Movie?) -> Void) {
        
        let host = APIBase + "/movie" + "/\(id)" + APIKey
        
        Alamofire.request(host, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                case .success(_):
                    handler(Movie((response.value as? [String: Any])!))
                case .failure(_):
                    break
                }
        }
    }
    func fetchSerieById(_ id: Int,handler: @escaping (Serie?) -> Void) {
        
        let host = APIBase + "/tv" + "/\(id)" + APIKey
        
        Alamofire.request(host, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                case .success(_):
                    handler(Serie((response.value as? [String: Any])!))
                case .failure(_):
                    break
                }
        }
    }
    func fetchActorById(_ id: Int,handler: @escaping (Actor?) -> Void) {
        
        let host = APIBase + "/person" + "/\(id)" + APIKey
        
        Alamofire.request(host, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                case .success(_):
                    handler(Actor((response.value as? [String: Any])!))
                case .failure(_):
                    break
                }
        }
    }
}
