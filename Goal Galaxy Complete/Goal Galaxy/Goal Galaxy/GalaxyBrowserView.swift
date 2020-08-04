//
//  GalaxyBrowser.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/18/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit
import FirebaseDatabase

class GalaxyBrowserView: UIViewController, UITableViewDelegate, UITableViewDataSource, GetGoalDelegate {
    
    
    //Tableview
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var galaxySymbol: UIImageView!
    //User contains the goals of the user for the tableView.
    var user : User?
    var selectedGoal : Goal?
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Number of rows per section is same as number of goals.
        return user?.goals?.count ?? 0
    }
    
    //Initialize tableview.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "browseCell", for: indexPath) as? BrowseTableViewCell
            else
        {
            return tableView.dequeueReusableCell(withIdentifier: "browseCell", for: indexPath)
        }
        
        cell.goalNameText?.text = user?.goals?[indexPath.row].name
        cell.goalDescriptionText?.text = user?.goals?[indexPath.row].desc
        
        if user?.goals?[indexPath.row].completed == "yes"{
            cell.galaxyImage?.image = #imageLiteral(resourceName: "GalaxyIconGreen")
        }
        else{
            cell.galaxyImage?.image = #imageLiteral(resourceName: "GalaxyIcon")
        }
        
        return cell
    }
    
    
    //Attach goal and perform segue if table row was selected.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedGoal = user?.goals?[indexPath.row]
        
        performSegue(withIdentifier: "toGalaxyView", sender: self)
    }

    //Add goal button pressed.
    @IBAction func addGoalButton(_ sender: Any) {
        performSegue(withIdentifier: "toCreateGalaxy", sender: self)
    }
    
    //Prepare for any segues and attach any data.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? CreateGalaxyView{
            dest.user = self.user
            dest.delegate = self
        }
        
        if let dest = segue.destination as? GalaxyView{
            dest.user = self.user
            dest.selectedGoal = self.selectedGoal
            dest.delegate = self
        }
        
        //Segue to followed users with reference to this user.
        if let dest = segue.destination as? FollowedUsersView{
            dest.user = self.user
        }
    }
    
    //Receive the goal if one was just made in CreateGalaxy and append it to list of goals and firebase or delete it if delete is true.
    func getGoal(goal: Goal, delete : Bool, complete: Bool) {
        
        if !delete && !complete
        {
        user?.goals?.append(goal)
        
        let name = user?.name ?? ""
        
        
        //Add this goal to database by username/goalname
        ref.child("users/\(String(name))/goals/\(String(goal.id))").setValue(["id": goal.id, "name": String(goal.name), "desc": String(goal.desc), "date": goal.date])
        
        //For each [i] progression add to this goal progress.
        for (i,_) in goal.progressions!.enumerated()
        {
            ref.child("users/\(name)/goals/\(String(goal.id))/progressions/").childByAutoId().setValue(["name": String(goal.progressions![i].name), "note": String(goal.progressions![i].note), "date": goal.progressions![i].date,"id": goal.progressions![i].id])
        }
        
            ref.child("users/\(String(name))/goals/\(String(goal.id))/completed").setValue(["completed": "no"])
            
        tableView.reloadData()
    }
        
        
        if delete
        {
            //This deletes a goal from firebase as well as the user.
            ref.child("users/\(user!.name as String)/goals/\(String(goal.id))").setValue([nil])
            
            //Find goal by id and delete it from array.
            for g in user!.goals!{
                
                if g.id == goal.id{
                    let i = user!.goals!.firstIndex{$0 === g}
                    user?.goals!.remove(at: i!)
                }
            }
            
            tableView.reloadData()
        }
        
        if complete{
            //This completes a goal in firebase as well as the user.
            
            ref.child("users/\(user!.name as String)/goals/\(String(goal.id))/completed").setValue(["completed": "yes"])
            
            //Find goal by id and delete it from array.
            for g in user!.goals!{
                
                if g.id == goal.id{
                    let i = user!.goals!.firstIndex{$0 === g}
                    user?.goals![i!].completed = "yes"
                }
            }
            tableView.reloadData()
            self.navigationController?.popViewController(animated: true)
        }
    }
}
