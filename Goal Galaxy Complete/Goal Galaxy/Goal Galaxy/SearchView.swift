//
//  SearchView.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/27/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchView: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    
    let ref = Database.database().reference()
    
    var followedUser : User?
    var user : User?
    @IBOutlet weak var followButton: UIButton!
    
    var delegate : GetUserDelegate?
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userGoalsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followButton.isHidden = true
        followButton.isEnabled = false
        userNameLabel.isHidden = true
        userGoalsLabel.isHidden = true
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
        //Get and parse user info.
        ref.child("users/\(searchField.text ?? "")").observeSingleEvent(of: .value){
            (snapshot) in
            
            
            //Get user.
            if let user = snapshot.value as? [String : [String:Any]]
            {
                
                //Enable the ui elements.
                self.followButton.isHidden = false
                self.followButton.isEnabled = true
                self.userNameLabel.isHidden = false
                self.userGoalsLabel.isHidden = false
                
                //Parse JSON for name/pass check.
                let val = user["data"]
                let uName = val?["username"] as! String
                
                self.followedUser = User(name: uName, goals: [Goal](), followedUsers: [User]())
                
                self.userNameLabel.text = self.followedUser?.name
                
                //Break down goals from JSON and build user if goals exist.
                let goals = user["goals"]
                
                if goals != nil
                {
                    self.userGoalsLabel.text = "Goals: \(goals!.count)"
                }
                else{
                    self.userGoalsLabel.text = "Goals: 0"
                }
            }
        }
    }
    
    @IBAction func followButton(_ sender: Any) {
        
        
        //Get and parse user info.
        ref.child("users/\(followedUser!.name)").observeSingleEvent(of: .value){
            (snapshot) in
            
            //If already following don't add another to the list.
            for u in self.user!.followedUsers{
                if u.name == self.userNameLabel?.text{
                    self.navigationController?.popViewController(animated: true)
                    return
                }
            }
            
            //Get user.
            if let user = snapshot.value as? [String : [String:Any]]
            {
                //This is the holder for the goals we are about to build.
                var userGoals = [Goal]()
                
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
                        if let progressions = goalDic?["progressions"] as? [String:Any]
                        {
                            for progressionDic in progressions{
                                let progressionValue = progressionDic.value as? [String:Any]
                                
                                let pDate = progressionValue?["date"] as! String
                                let pName = progressionValue?["name"] as! String
                                let pNote = progressionValue?["note"] as! String
                                let pID = progressionValue?["id"] as! Int
                                
                                //Add progressions to progressions array.
                                userProgressions.append(Progression( name: pName, note: pNote, date: pDate, id: pID))
                            }
                            //Add the goals with their progressions to the user.
                            userGoals.append(Goal(id : id,name: name, desc: desc, date: date, progressions: userProgressions,completed: isComplete))
                        }
                    }
                }
                
                self.followedUser?.goals? = userGoals
                
                self.user?.followedUsers.append(self.followedUser!)
                
                self.delegate?.getUser(user: self.followedUser!, unfollow: false)
                
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }
}
