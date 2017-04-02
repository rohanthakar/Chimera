//
//  SignInVC.swift
//  Chimera
//
//  Created by Rohan Thakar on 29/03/17.
//  Copyright © 2017 Reverie Works. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase


class SignInVC: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: -Facebook Authentication when FB Login Button Pressed
    @IBAction func fbBtnPressed(_ sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email","user_birthday","public_profile","user_about_me"], from: self) { (result, error) in
            
            if error != nil {
                print("Rohan: Unable to authenticate with Fb")
            } else if result?.isCancelled == true {
                print("Rohan: User Cancelled Fb Auth")
            }else {
                print("Rohan: Successfully Authenticated with Facebook")
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                
                self.firebaseAuth(credential)
                
            }
            
        }
        
        
    }
    
    //MARK: - Firebase Authentication Function
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
               print("Rohan: Unable to authenticate with Firebase- \(String(describing: error))")
            }else {
                print("Rohan: Successfully Authenticated with Firebase")
            }
            
        })

    }
    @IBAction func signInTapped(_ sender: Any) {
        
        if let email = emailField.text, let password = passwordField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {(user, error) in
            
                if error == nil {
                    print("ROHAN: Email User Authenticated with Firebase")
                }else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user, error) in
                        
                        if error != nil {
                            print("ROHAN: Unable to Authenticate with Firebase using Email \(String(describing: error))")
                        }else {
                            print("ROHAN: Successufully Authenticated with Firebase")
                        }
                    })
                }
            })
        }
    }
}

