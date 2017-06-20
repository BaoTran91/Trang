//
//  SettingsViewModel.swift
//  Trang
//
//  Created by Bao Tran on 6/17/17.
//  Copyright © 2017 Bao Tran. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension SettingsViewController {
    
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
}
