//
//  FollowedUsers.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/26/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit
import FirebaseDatabase
class FollowedUsers: UIViewController, UITableViewDelegate, UITableViewDataSource, GetUserDelegate{
    

    @IBOutlet weak var tableView: UITableView!
    
    let ref = Database.database().reference()
    
    //This is the logged in user and has followed user list inside it.
    var user : User?
    var followedUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
             return (user?.followedUsers.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "followedGoalCell", for: indexPath) as? FollowedUserTableViewCell
            else
        {
            return tableView.dequeueReusableCell(withIdentifier: "followedGoalCell", for: indexPath)
        }
        
        
        cell.userName?.text = ("\((user?.followedUsers[indexPath.row].name)! as String)")
        cell.numberOfGoals?.text = ("Goals: \( (user?.followedUsers[indexPath.row].goals!.count) ?? 0)")
        
        return cell
    }
    
    //Attach goal and perform segue.
          func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            followedUser = user?.followedUsers[indexPath.row]
            
            performSegue(withIdentifier: "toFollowedGalaxyBrowser", sender: self)
          }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? FollowedGalaxyBrowserViewController{
            dest.user = self.user
            dest.followedUser = self.followedUser
            dest.delegate = self
        }
        
        if let dest = segue.destination as? SearchView{
            dest.delegate = self
            dest.user = self.user
        }
    }
    
    
    @IBAction func searchButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toSearch", sender: self)
    }
    
    func getUser(user: User, unfollow: Bool) {
        
        if !unfollow{
            user.followedUsers.append(user)
            
            ref.child("users/\((self.user?.name)! as String)/followed/\(user.name)").setValue("")
            
            tableView.reloadData()
        }
        else{
            
            for u in self.user!.followedUsers{
                
                if(u.name == user.name){
                    let i = self.user!.followedUsers.firstIndex{$0 === u}
                    self.user!.followedUsers.remove(at: i!)
                    
                    ref.child("users/\((self.user?.name)! as String)/followed/\(user.name)").setValue(nil)
                }
            }
            
            tableView.reloadData()
        }
        
    }
    
    @IBAction func myGalaxies(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
