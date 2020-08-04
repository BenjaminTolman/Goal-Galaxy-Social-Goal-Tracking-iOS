//
//  CreateAccount.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/24/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CreateAccountView: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Create an account and save it to Firebase.
    @IBAction func createAccountButton(_ sender: Any) {
        
        if usernameField.text?.isEmpty == false && passwordField.text?.isEmpty == false{
            
            let username = (usernameField?.text)! as String
            let password = (passwordField?.text)! as String
            
            ref.child("users/\(username)/data").setValue(["username": "\(username)", "password": "\(password)"])
            
                
            navigationController?.popViewController(animated: true)
        }
            
        //If fields are left blank then warning.
        else{
            let alert = UIAlertController(title: "Missing Information", message: "Please fill all fields.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        
        
    }
    
}
