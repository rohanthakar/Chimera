//
//  SignUpVC.swift
//  Chimera
//
//  Created by Rohan Thakar on 28/04/17.
//  Copyright © 2017 Reverie Works. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    
    var chosenPic: UIImage?
    
    
    
    @IBOutlet weak var addProfileImage: CircleView!
    
        override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
            
        handleTextField()
    }

    //MARK: - Image Picker Code Begins
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            chosenPic = image
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
   
    //Image Picker Code Ends
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: {(user, error) in
            
            if error != nil {
                print("ROHAN: Unable to Authenticate with Firebase using Email \(String(describing: error))")
            }else {
                print("ROHAN: Successufully Authenticated with Firebase")
                
                
                //Adding New User to FIRDB
                
                let storageRef = DataService.ds.REF_PROFILE_IMAGES.child((user?.uid)!)
               
                if let profilePic = self.chosenPic, let imageData = UIImageJPEGRepresentation(profilePic, 0.1) {
                    
                    storageRef.put(imageData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            return
                        }
                        
                        let profilImageUrl = metadata?.downloadURL()?.absoluteString
                        
                        
                        
                        if let user = user {
                            let userData = ["provider": user.providerID,"username":self.usernameField.text!,"email":self.emailField.text!,"profileImageUrl": profilImageUrl!] as [String : Any]
                            
                            self.completeSignIn(id: (user.uid), userData: userData as! Dictionary<String, String>)
                        }
                    
                    })
                }
                
                
                
                
                
                
            }
        })

        
        
    }
    
    func handleTextField() {
        usernameField.addTarget(self, action: #selector(SignUpVC.textFieldDidChange), for: UIControlEvents.editingChanged)
        emailField.addTarget(self, action: #selector(SignUpVC.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordField.addTarget(self, action: #selector(SignUpVC.textFieldDidChange), for: UIControlEvents.editingChanged)

    }
    
    func textFieldDidChange() {
        guard let username = usernameField.text, !username.isEmpty, let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty
            else {
            
                signUpBtn.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
                signUpBtn.isEnabled = false
                return
                
        }
        signUpBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        signUpBtn.isEnabled = true
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        
        let keyChainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("ROHAN: Data saved to keychain \(String(describing:keyChainResult))")
        
        //performSegue(withIdentifier: "goToFeed", sender: nil)
        
    }
    
    
    
}
