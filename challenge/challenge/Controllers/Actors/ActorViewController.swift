//
//  ActorViewController.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/15/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit

class ActorViewController: UIViewController {
    
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorImage: UIImageView!
    
    var actorId: Int!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIManager.sharedInstance.fetchActorById(actorId!){ (response) in
            self.actorName.text = response!.name
            if let url = URL(string: response!.profileURL){
                self.actorImage.af_setImage(withURL: url)
            }
        }
    }
    @IBAction func goToBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
