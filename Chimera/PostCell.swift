//
//  PostCell.swift
//  Chimera
//
//  Created by Rohan Thakar on 02/04/17.
//  Copyright © 2017 Reverie Works. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        self.locationLbl.text = post.location
        
        if img != nil {
            self.postImg.image = img
        }else {
                let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    if error != nil {
                        print("ROHAN: Unable to download image from Firbase Storage")
                    }else {
                        print("ROHAN: Image Downloaded from Firbase Storage")
                        if let imgData = data {
                            if let img = UIImage(data: imgData){
                                self.postImg.image = img
                                ImageFeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                            }
                        }
                    }
                    
                })
            
        }
        
    }
    
    
    
}
