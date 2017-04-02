//
//  CircleView.swift
//  Chimera
//
//  Created by Rohan Thakar on 02/04/17.
//  Copyright © 2017 Reverie Works. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func layoutSubviews() {
        layer.cornerRadius = frame.width / 2.0
        layer.shadowOpacity = 2.5
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
       
    }

}
