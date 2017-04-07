//
//  SettingBtn.swift
//  Chimera
//
//  Created by Rohan Thakar on 02/04/17.
//  Copyright © 2017 Reverie Works. All rights reserved.
//

import UIKit

class SettingBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = frame.width / 2
        layer.shadowOpacity = 0
        
    }

}
