//
//  GalaxyView.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/19/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

//MARK: This view is for looking at a galaxy.

import UIKit

class GalaxyView: UIViewController, UITableViewDelegate, UITableViewDataSource, GetGoalDelegate{
    
    var user : User?
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedGoal: Goal?
    var progressions: [Progression]?
    
    var delegate: GetGoalDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        progressions = selectedGoal?.progressions
        
        progressions?.sort(by: { $0.id > $1.id })
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedGoal!.progressions!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == selectedGoal!.progressions!.count  - 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GalaxyTableViewCell
                else
            {
                return tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath)
            }
            
            //TODO get dates from class
            cell.progressName?.text = ("\(progressions![indexPath.row].name)")
                
            cell.progressDate?.text = ("\(progressions![indexPath.row].date)")
            
            cell.progressNote?.text = ("\(progressions![indexPath.row].note)")
            
            return cell
        }
        else {
            
            if indexPath.row % 2 == 0{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell2", for: indexPath) as? GalaxyTableViewCell
                    else
                {
                    return tableView.dequeueReusableCell(withIdentifier: "goalCell2", for: indexPath)
                }
                
                //TODO get dates from class
                cell.progressName?.text = ("\(progressions![indexPath.row].name)")
                    
                cell.progressDate?.text = ("\(progressions![indexPath.row].date)")
                
                cell.progressNote?.text = ("\(progressions![indexPath.row].note)")
                
                return cell
            }
            
            else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell3", for: indexPath) as? GalaxyTableViewCell
                    else
                {
                    return tableView.dequeueReusableCell(withIdentifier: "goalCell3", for: indexPath)
                }
                
                //TODO get dates from class
                cell.progressName?.text = ("\(progressions![indexPath.row].name)")
                    
                cell.progressDate?.text = ("\(progressions![indexPath.row].date)")
                
                cell.progressNote?.text = ("\(progressions![indexPath.row].note)")
                
                return cell
            }
        }
    }
    
    //Button to add progression was clicked.
    @IBAction func addProgressionButton(_ sender: Any)
    {
    
        performSegue(withIdentifier: "toProgressView", sender: self)
        
    }
    
    //Send the user and goals over with segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ProgressView{
            dest.currentUser = self.user
            dest.delegate = self
            dest.goal = selectedGoal
        }
    }
    
    //Gets the goal back and sorts progressions by ID so that they are arranged correctly in the table.
    func getGoal(goal: Goal, delete: Bool, complete: Bool) {
        
        selectedGoal = nil
        progressions = nil
        
        selectedGoal = goal
        progressions = selectedGoal?.progressions
        
        progressions?.sort(by: { $0.id > $1.id })
        tableView.reloadData()
    }
    
    //TODO delete goal
    @IBAction func deleteThisGalaxy(_ sender: Any) {
        
        for goal in user!.goals!{
            
            if goal.id == selectedGoal!.id{
                
                delegate?.getGoal(goal: selectedGoal!, delete: true, complete: false)
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func markComplete(_ sender: Any) {
        
        for goal in user!.goals!{
            
            if goal.id == selectedGoal!.id{
                
                delegate?.getGoal(goal: selectedGoal!, delete: false, complete: true)
            }
        }
    }
    
}
