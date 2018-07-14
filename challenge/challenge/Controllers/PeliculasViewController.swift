//
//  PeliculasViewController.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/13/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit

class PeliculasViewController: UIViewController {

    var movies: [Movie]?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ServerManager.sharedInstance.getListaPeliculas(){ (response) in
            self.movies = response!.movies
            print(response!.movies[0].overview)
        }
    }
}
