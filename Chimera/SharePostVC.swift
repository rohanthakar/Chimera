//
//  SharePostVC.swift
//  Chimera
//
//  Created by Rohan Thakar on 02/04/17.
//  Copyright © 2017 Reverie Works. All rights reserved.
//

import UIKit
import Firebase

class SharePostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addImg: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    var post: Post!
    var imageFeed: ImageFeedVC!
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelBtnPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImg.image = image
            imageSelected = true
        }else {
            print("ROHAN: A valid image wasnt selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func postBtnPressed(_ sender: UIButton) {
        
        guard let caption = captionField.text, caption != "" else {
            print("ROHAN: Caption must be empty")
            return
            
        }
        guard let img = addImg.image, imageSelected == true else {
            print("ROHAN: Image Must be selected")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            
            let imguid = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            DataService.ds.REF_POST_PICS.child(imguid).put(imgData,metadata: metadata) {(metadata, error) in
            
                if error != nil {
                    print("ROHAN: Unable to upload image to firebase storage")
                }else {
                    print("ROHAN: Successfully uploaded image to firebase storage")
                    let downloadUrl = metadata?.downloadURL()?.absoluteString
                    if let url = downloadUrl {
                        self.postToFirebase(imgUrl: url)
                        
                        //self.imageFeed.tableView.reloadData()
                        
                    }
                    
                    
                }
                
            }
        }
        
    }
    
    func postToFirebase(imgUrl: String) {
        
        let post: Dictionary<String, AnyObject> = [
            "caption": captionField.text as AnyObject,
            "imageUrl": imgUrl as AnyObject,
            "likes": 0 as AnyObject,
            "location": locationField.text as AnyObject,
            ]
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        captionField.text = ""
        imageSelected = false
        addImg.image = UIImage(named: "add-image")
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
}
