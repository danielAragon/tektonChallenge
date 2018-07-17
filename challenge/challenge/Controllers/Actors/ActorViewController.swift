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
    @IBOutlet weak var actorBirthday: UILabel!
    @IBOutlet weak var actorGender: UILabel!
    @IBOutlet weak var actorBiography: UILabel!
    @IBOutlet weak var actorCity: UILabel!
    
    var actorId: Int!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIManager.sharedInstance.fetchActorById(actorId!){ (response) in
            self.actorName.text = response!.name
            self.actorBirthday.text = response!.birthday
            self.actorGender.text = response!.gender! == 2 ? "Male" : (response!.gender! == 1 ? "Female" : "N/A")
            self.actorBiography.text = response!.biography!
            self.actorCity.text = response!.city!
            if let url = URL(string: response!.profileURL){
                self.actorImage.af_setImage(withURL: url)
            }
        }
    }
    @IBAction func goBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
