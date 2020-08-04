//
//  FollowedGalaxyBrowserViewController.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/26/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FollowedGalaxyBrowserView: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    let ref = Database.database().reference()
    
    var user : User?
    var followedUser : User?
    var followedGoal : Goal?
    
    var delegate: GetUserDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Number of rows per section is same as number of goals.
        
        return followedUser?.goals?.count ?? 0
    }
    
    //Initialize tableview.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "browserCell", for: indexPath) as? FollowedGalaxyCell
            else
        {
            return tableView.dequeueReusableCell(withIdentifier: "browserCell", for: indexPath)
        }
        
        cell.goalName?.text = followedUser?.goals?[indexPath.row].name
        cell.goalDesc?.text = followedUser?.goals?[indexPath.row].desc
        
        if followedUser?.goals?[indexPath.row].completed == "yes"{
            cell.galaxyImage?.image = #imageLiteral(resourceName: "GalaxyIconGreen")
        }
        else{
            cell.galaxyImage?.image = #imageLiteral(resourceName: "GalaxyIcon")
        }
        
        return cell
    }

    //Attach goal and perform segue if table row was selected.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        followedGoal = followedUser?.goals?[indexPath.row]
        
        performSegue(withIdentifier: "toFollowedGalaxyView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? FollowedGalaxyView{
            dest.followedGoal = self.followedGoal
    }
    }
    
    
    //Return the followed user and delete it in callback.
    @IBAction func unfollowButton(_ sender: Any) {
        delegate?.getUser(user: followedUser!, unfollow: true)
        
        navigationController?.popViewController(animated: true)
    }
}
