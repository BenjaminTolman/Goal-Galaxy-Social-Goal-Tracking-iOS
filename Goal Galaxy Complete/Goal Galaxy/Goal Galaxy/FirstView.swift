//
//  ViewController.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/9/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirstView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    var user : User?
    var username = ""
    var pass = ""
    var followedUsers = [String]()
    var myFollowedUsers = [User]()
    var followedUserGoals = [Goal]()
    
    let ref = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        passTextField.delegate = self
        
    }
    
    //Verify login credentials and act accordingly.
    @IBAction func loginButton(_ sender: Any) {
        
       
        if userNameTextField.text?.isEmpty == false || passTextField.text?.isEmpty == false{
            
            self.user = User(name: self.userNameTextField.text ?? "" , goals: [Goal](), followedUsers: [User]())
            username = userNameTextField?.text ?? ""
            pass = passTextField?.text ?? ""
            
        }
            
        else
        {
            //Show alert if blank fields.
            showAlert()
            return
        }
        
        //Get and parse user info.
        ref.child("users/\(username)").observeSingleEvent(of: .value){
            (snapshot) in
            
            //Get user.
            if let user = snapshot.value as? [String : [String:Any]]
            {
                 
                //Parse JSON for name/pass check.
                let val = user["data"]
                let p = val?["password"] as! String
                
                if p != (self.passTextField?.text ?? "") as String
                {
                    
                    //If pass is not correct show error and return.
                    self.showAlert()
                    return
                }
                
                let followed = user["followed"] as? [String : String]
                
                if followed != nil{
                    for v in followed!.keys{
                        
                        self.ref.child("users/\(v)").observeSingleEvent(of: .value){
                            (snapshot) in
                            
                            //Get user.
                            if let followedUser = snapshot.value as? [String : [String:Any]]
                            {
                                //This is the holder for the goals we are about to build.
                                var userGoals = [Goal]()
                                
                                //Break down goals from JSON and build user if goals exist.
                                let followedgoals = followedUser["goals"]
                                
                                if followedgoals != nil
                                {
                                    for goal in followedgoals!
                                    {
                                        let goalDic = goal.value as? [String:Any]
                                        
                                        let date = goalDic?["date"] as! String
                                        let name = goalDic?["name"] as! String
                                        let desc = goalDic?["desc"] as! String
                                        let id = goalDic?["id"] as! String
                                        
                                        
                                        let completed = goalDic?["completed"] as? [String:Any]
                                        let isComplete = completed?["completed"] as! String
                                        
                                        var userProgressions = [Progression]()
                                        
                                        //Break down progressions for goals as well.
                                        let progressions = goalDic?["progressions"] as? [String:Any]
                                        
                                        for progressionDic in progressions!{
                                            let progressionValue = progressionDic.value as? [String:Any]
                                            
                                            let pDate = progressionValue?["date"] as! String
                                            let pName = progressionValue?["name"] as! String
                                            let pNote = progressionValue?["note"] as! String
                                            let pID = progressionValue?["id"] as! Int
                                            
                                            //Add progressions to progressions array.
                                            userProgressions.append(Progression( name: pName, note: pNote, date: pDate, id: pID))
                                        }
                                        userGoals.append(Goal(id: id, name: name, desc: desc, date: date, progressions: userProgressions, completed: isComplete))
                                    }
                                }
                                
                                //Add the goals with their progressions to the user.
                                self.user!.followedUsers.append(User(name: v, goals: userGoals, followedUsers: [User]()))
                            }
                        }
                    }
                }
                   
                    //Break down goals from JSON and build user if goals exist.
                    let goals = user["goals"]
                    
                    if goals != nil
                    {
                        for goal in goals!
                        {
                            let goalDic = goal.value as? [String:Any]
                            
                            let date = goalDic?["date"] as! String
                            let name = goalDic?["name"] as! String
                            let desc = goalDic?["desc"] as! String
                            let id = goalDic?["id"] as! String
                            
                            var userProgressions = [Progression]()
                            
                            let completed = goalDic?["completed"] as? [String:Any]
                            let isComplete = completed?["completed"] as! String
                            
                            
                            //Break down progressions for goals as well.
                            let progressions = goalDic?["progressions"] as? [String:Any]
                            
                            for progressionDic in progressions!{
                                let progressionValue = progressionDic.value as? [String:Any]
                                
                                let pDate = progressionValue?["date"] as! String
                                let pName = progressionValue?["name"] as! String
                                let pNote = progressionValue?["note"] as! String
                                let pID = progressionValue?["id"] as! Int
                                
                                //Add progressions to progressions array.
                                userProgressions.append(Progression( name: pName, note: pNote, date: pDate, id: pID))
                            }
                            
                            //Add the goals with their progressions to the user.
                            self.user?.goals?.append(Goal(id: id, name: name, desc: desc, date: date, progressions: userProgressions, completed: isComplete))
                        }
                    }
                    
                    //Go to goal browser after building user and goals.
                    self.performSegue(withIdentifier: "toGalaxyBrowser", sender: self)
                }
            }
        }
    
        //Prepare for segue and send this user to the goal browser.
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let dest = segue.destination as? GalaxyBrowserView{
                
                //Set back button text to "Log Out".
                let backItem = UIBarButtonItem()
                backItem.title = "Log Out"
                navigationItem.backBarButtonItem = backItem
                
                dest.user = self.user
            }
        }
        
        //This is here because we use this alert in two instances.
        func showAlert(){
            let alert = UIAlertController(title: "Login Failed", message: "Username or Password do not match.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
}

