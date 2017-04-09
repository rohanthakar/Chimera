//
//  ImageFeedVC.swift
//  Chimera
//
//  Created by Rohan Thakar on 02/04/17.
//  Copyright © 2017 Reverie Works. All rights reserved.
//

import UIKit
import Firebase


class ImageFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
   
    static var imageCache: NSCache<NSString,UIImage> = NSCache()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        DataService.ds.REF_POSTS.observe(.value, with: {(snapshot) in
        
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
                
            }
             self.tableView.reloadData()
            
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            if let img = ImageFeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
               cell.configureCell(post: post, img: img)
                return cell
            }else {
                 cell.configureCell(post: post)
                 return cell
            }
            
            
        }else {
             return PostCell()
        }
  
    }

}
