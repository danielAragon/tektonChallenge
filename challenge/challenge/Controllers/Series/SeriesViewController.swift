//
//  SeriesViewController.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/13/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit
class SerieCell: UITableViewCell{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var serieImage: UIImageView!
}
class SeriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var currentSeries: [Serie]?
    var seriesList: [Serie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIManager.sharedInstance.fetchSeries(){ (response) in
            self.currentSeries = response!.series
            self.seriesList = response!.series
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let _ =  currentSeries{
            return 1
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentSeries!.count < 20{
            return currentSeries!.count
        }else{
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let serieCell = tableView.dequeueReusableCell(withIdentifier: String(describing: SerieCell.self), for: indexPath) as! SerieCell
        serieCell.name.text = currentSeries![indexPath.row].name
        serieCell.overview.text = currentSeries![indexPath.row].overview
        if let url = URL(string: currentSeries![indexPath.row].posterURL){
            serieCell.serieImage.af_setImage(withURL: url)
        }
        return serieCell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentSeries = seriesList
            tableView.reloadData()
            return
        }
        currentSeries = seriesList?.filter({serie -> Bool in
            serie.name.contains(searchText)
        })
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSerie",
            let destination = segue.destination as? SerieViewController,
            let row = tableView.indexPathForSelectedRow?.row{
            destination.serieId = currentSeries![row].id
        }
    }
}
