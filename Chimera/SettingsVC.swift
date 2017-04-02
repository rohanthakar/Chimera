//
//  SettingsVC.swift
//  Chimera
//
//  Created by Rohan Thakar on 02/04/17.
//  Copyright © 2017 Reverie Works. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func bckBtnPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signoutBtnPressed(_ sender: UIButton) {
        
       let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        print("ROHAN: ID removed from keychain \(keychainResult)")
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
}
