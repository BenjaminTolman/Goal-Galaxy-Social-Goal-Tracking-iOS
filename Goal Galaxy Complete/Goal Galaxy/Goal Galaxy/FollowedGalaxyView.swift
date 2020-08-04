//
//  FollowedGalaxyViewViewController.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/27/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit

class FollowedGalaxyView: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var followedGoal : Goal?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return followedGoal!.progressions!.count
    }
    
    //Set cells and images.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == followedGoal!.progressions!.count  - 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "followedGoalCell", for: indexPath) as? GalaxyTableViewCell
                else
            {
                return tableView.dequeueReusableCell(withIdentifier: "followedGoalCell", for: indexPath)
            }
            
            cell.progressName?.text = ("\( (followedGoal?.progressions![indexPath.row].name)! as String)")
                
            cell.progressDate?.text = ("\(( followedGoal?.progressions![indexPath.row].date)! as String)")
            
            cell.progressNote?.text = ("\(( followedGoal?.progressions![indexPath.row].note)! as String)")
            
            return cell
        }
        else {
            
            if indexPath.row % 2 == 0{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "followedGoalCell2", for: indexPath) as? GalaxyTableViewCell
                    else
                {
                    return tableView.dequeueReusableCell(withIdentifier: "followedGoalCell2", for: indexPath)
                }
                
                cell.progressName?.text = ("\( (followedGoal?.progressions![indexPath.row].name)! as String)")
                    
                cell.progressDate?.text = ("\(( followedGoal?.progressions![indexPath.row].date)! as String)")
                
                cell.progressNote?.text = ("\(( followedGoal?.progressions![indexPath.row].note)! as String)")
                
                return cell
            }
            
            else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "followedGoalCell3", for: indexPath) as? GalaxyTableViewCell
                    else
                {
                    return tableView.dequeueReusableCell(withIdentifier: "followedGoalCell3", for: indexPath)
                }
                
                cell.progressName?.text = ("\( (followedGoal?.progressions![indexPath.row].name)! as String)")
                    
                cell.progressDate?.text = ("\(( followedGoal?.progressions![indexPath.row].date)! as String)")
                
                cell.progressNote?.text = ("\(( followedGoal?.progressions![indexPath.row].note)! as String)")
                
                return cell
            }
        }
    }
}
