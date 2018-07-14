//
//  ServerManager.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/13/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

public struct ServerManager{
    
    static let sharedInstance = ServerManager()

    func getListaPeliculas(handler: @escaping (MovieApiResponse?) -> Void) {
        let host = "https://api.themoviedb.org/3/movie/popular?api_key=07db23794cd348240def66ce0def1c34"
        Alamofire.request(host, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                case .success(_):
                    handler(MovieApiResponse((response.value as? [String: Any])!))
                case .failure(_):
                    break
                }

        }
    }
}
