//
//  ActorsViewController.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/13/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit
class ActorCell: UITableViewCell{
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var actorImage: UIImageView!
}
class ActorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var currentActors: [Actor]?
    var actorsList: [Actor]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIManager.sharedInstance.fetchActors(){ (response) in
            self.currentActors = response!.actors
            self.actorsList = response!.actors
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let _ =  currentActors{
            return 1
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentActors!.count < 20{
            return currentActors!.count
        }else{
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let actorCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActorCell.self), for: indexPath) as! ActorCell
        actorCell.name.text = currentActors![indexPath.row].name
        var overviewText = "Known for:"
        for play in currentActors![indexPath.row].plays{
            overviewText += "\n\(play.appellation!)"
        }
        actorCell.overview.text = overviewText
        if let url = URL(string: currentActors![indexPath.row].profileURL){
            actorCell.actorImage.af_setImage(withURL: url)
        }
        return actorCell
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentActors = actorsList
            tableView.reloadData()
            return
        }
        currentActors = actorsList?.filter({actor -> Bool in
            actor.name.contains(searchText)
        })
        tableView.reloadData()
    }
    
}
