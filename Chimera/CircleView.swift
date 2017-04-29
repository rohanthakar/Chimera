//
//  CircleView.swift
//  Chimera
//
//  Created by Rohan Thakar on 02/04/17.
//  Copyright © 2017 Reverie Works. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.frame.width / 2
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    /*override func layoutSubviews() {
        
        layer.cornerRadius = self.frame.width / 2
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
    }*/

}
