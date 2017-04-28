//
//  DataService.swift
//  Chimera
//
//  Created by Rohan Thakar on 08/04/17.
//  Copyright © 2017 Reverie Works. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    //DB References
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    
    //Storage Rerences
    private var _REF_POST_PICS = STORAGE_BASE.child("post-pics")
    private var _REF_PROFILE_PICS = STORAGE_BASE.child("profile-pics")
    
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_USERS_CURRENT: FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
       
        return user
    }
    
    var REF_POST_PICS: FIRStorageReference {
        return _REF_POST_PICS
    }
    var REF_PROFILE_IMAGES: FIRStorageReference {
        return _REF_PROFILE_PICS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    
    
    
}
