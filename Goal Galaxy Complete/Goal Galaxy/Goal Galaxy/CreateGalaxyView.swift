//
//  CreateGalaxy.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/18/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CreateGalaxyView: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var goalNameText: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    let ref = Database.database().reference()
    
    var user : User?
    
    var delegate: GetGoalDelegate?
    var goal: Goal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.delegate = self
        
        descriptionTextView.text = "Enter description of your goal."
        descriptionTextView.textColor = UIColor.lightGray
    }
    
    //Placeholder text for the description text view.
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text =  "Enter description of your goal."
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func postGoalButton(_ sender: Any) {
       
        //If there is a goal in the fields then create one.
        if goalNameText.text?.isEmpty == false
            && descriptionTextView.textColor != UIColor.lightGray
        && goalNameText.textColor != UIColor.lightGray
        {
            
            //Dismiss this view controller.
            navigationController?.popViewController(animated: true)
            
            
            //Get the current date and time
            let currentDateTime = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .long
            formatter.string(from: currentDateTime)
            
            //Send this goal back via the delegate.
            var progressions = [Progression]()
            
            progressions.append(Progression(name: "A galaxy is born.", note: "The \(String(goalNameText.text!)) Galaxy is born",
                                            date: formatter.string(from: currentDateTime), id: 1))
            
            let identifier = UUID()
            
            let newGoal = Goal(id: identifier.uuidString ,name: goalNameText.text!, desc: descriptionTextView.text, date: formatter.string(from: currentDateTime), progressions: progressions, completed: "no")
            
            delegate?.getGoal(goal:newGoal, delete: false, complete: false)
        }
        
        //Validate fields and give warning if incorrect.
        else{
            let alert = UIAlertController(title: "Empty Fields", message: "Please enter information in all fields.", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
}

