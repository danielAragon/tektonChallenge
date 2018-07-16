//
//  SerieViewController.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/15/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit
import Cosmos

class SerieViewController: UIViewController {

    @IBOutlet weak var serieName: UILabel!
    @IBOutlet weak var voteAverage: CosmosView!
    @IBOutlet weak var serieImage: UIImageView!
    @IBOutlet weak var overview: UILabel!
//    @IBOutlet weak var budget: UILabel!
    
    var serieId: Int!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIManager.sharedInstance.fetchSerieById(serieId!){ (response) in
            self.serieName.text = response!.name
            self.overview.text = response!.overview
            self.voteAverage.rating = Double(response!.voteAverage/2.0)
//            if let budget = response!.budget{
//                self.budget.text = "Budget: \(budget)"
//            }else { self.budget.text = "" }

            if let url = URL(string: response!.posterURL){
                self.serieImage.af_setImage(withURL: url)
            }
        }
    }
    @IBAction func goToBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
