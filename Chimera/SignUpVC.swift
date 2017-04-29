//
//  SignUpVC.swift
//  Chimera
//
//  Created by Rohan Thakar on 28/04/17.
//  Copyright © 2017 Reverie Works. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker: UIImagePickerController!
    var imageSelected = false
    
    @IBOutlet weak var addProfileImage: CircleView!
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addProfileImage.image = image
            imageSelected = true
        }else {
            print("ROHAN: A valid image wasnt selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }

    
    @IBAction func goToLoginPagePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
   

    
}
