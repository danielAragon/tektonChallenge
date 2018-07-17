//
//  MoviesViewController.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/13/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell{
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
}


class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var page: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var serchBar: UISearchBar!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var currentMovies: [Movie]?
    var moviesList: [Movie]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.serchBar.delegate = self
        self.page.text = "1"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIManager.sharedInstance.fetchMovies(self.page.text!){ (response) in
            self.currentMovies = response!.movies
            self.moviesList = response!.movies
            self.tableView.reloadData()
        }
        
        let size: CGSize = UIScreen.main.bounds.size
        if size.width / size.height > 1 {
            self.topConstraint.constant = -40
        } else {
            self.topConstraint.constant = -116
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let _ =  currentMovies{
            return 1
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentMovies!.count < 20{
            return currentMovies!.count
        }else{
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as! MovieCell
        movieCell.title.text = currentMovies![indexPath.row].title
        movieCell.overview.text = currentMovies![indexPath.row].overview
        if let url = URL(string: currentMovies![indexPath.row].posterURL){
            movieCell.movieImage.af_setImage(withURL: url)
        }
        return movieCell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentMovies = moviesList
            tableView.reloadData()
            return
        }
        currentMovies = moviesList?.filter({movie -> Bool in
            movie.title.contains(searchText)
        })
        tableView.reloadData()
    }
    
    @IBAction func nextPage(_ sender: Any) {
        self.page.text = "\(Int(self.page.text!)! + 1)"
        APIManager.sharedInstance.fetchMovies(self.page.text!){ (response) in
            self.currentMovies = response!.movies
            self.moviesList = response!.movies
            self.tableView.reloadData()
        }
    }
    @IBAction func beforePage(_ sender: Any) {
        guard Int(self.page.text!)! > 1 else {
            return
        }
        self.page.text = "\(Int(self.page.text!)! - 1)"
        APIManager.sharedInstance.fetchMovies(self.page.text!){ (response) in
            self.currentMovies = response!.movies
            self.moviesList = response!.movies
            self.tableView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovie",
            let destination = segue.destination as? MovieViewController,
            let row = tableView.indexPathForSelectedRow?.row{
            destination.movieId = currentMovies![row].id
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.topConstraint?.constant = -40
        } else {
            self.topConstraint?.constant = -116
        }
    }
}
