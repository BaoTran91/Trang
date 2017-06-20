//
//  HomeViewModel.swift
//  Trang
//
//  Created by Bao Tran on 6/18/17.
//  Copyright © 2017 Bao Tran. All rights reserved.
//

import Foundation
import  UIKit
import Firebase

extension HomeViewController {
    func handleLogOut() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        if let loginView = storyboard?.instantiateViewController(withIdentifier: "loginView") as? LoginViewController {
            self.present(loginView, animated: true, completion: nil)
        }
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogOut), with: nil, afterDelay: 0)
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.welcomeLabel.text = "Welcome " + (dictionary["name"] as? String)!
                }
                
            }, withCancel: nil)
            print("User Found")
        }
    }
    
    //Use as an observer to dismiss views
    func dismissView() {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "dismiss"), object: nil)
    }
}
