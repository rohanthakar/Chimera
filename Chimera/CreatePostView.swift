//
//  CreatePostView.swift
//  Chimera
//
//  Created by Rohan Thakar on 02/04/17.
//  Copyright © 2017 Reverie Works. All rights reserved.
//

import UIKit

class CreatePostView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 1.0).cgColor
        
        layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        
        layer.shadowOpacity = 5.0
        
        
        
    }
    
    


}
