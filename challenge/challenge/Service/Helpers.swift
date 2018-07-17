//
//  Helpers.swift
//  challenge
//
//  Created by Daniel Aragon Ore on 7/16/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import Foundation
import UIKit

class CustomImage: UIImageView{
    func addBlackGradientLayer(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    override func awakeFromNib() {
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 4
        super.awakeFromNib()
    }
    
}
