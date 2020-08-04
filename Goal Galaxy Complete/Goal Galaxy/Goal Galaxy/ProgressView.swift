//
//  ProgressView.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/20/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProgressView: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var progressTitleField: UITextField!
    @IBOutlet weak var progressNoteField: UITextView!
    
    var currentUser : User?
    
    let ref = Database.database().reference()
    
    var goal: Goal?
    var delegate: GetGoalDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressNoteField.delegate = self
        
        progressNoteField.text = "Enter description of your goal."
        progressNoteField.textColor = UIColor.lightGray
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
            textView.text =  "Enter description of your Progress."
            textView.textColor = UIColor.lightGray
        }
    }
    
 
    @IBAction func add(_ sender: Any) {
        
       
        if progressTitleField.text?.isEmpty == false
            && progressNoteField.textColor != UIColor.lightGray && progressTitleField.textColor != UIColor.lightGray
        {
            
            
            //Get the current date and time
            let currentDateTime = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .long
            
            
            let prog = Progression(name: progressTitleField.text!, note: progressNoteField.text, date: formatter.string(from: currentDateTime),id: (goal?.progressions?.count)! + 1)
            
            goal?.progressions?.append(prog)
            
            ref.child("users/\(currentUser!.name)/goals/\(goal!.id)/progressions/").setValue(nil)
            //Save progression to database.
            for (i,_) in goal!.progressions!.enumerated()
            {
                ref.child("users/\(currentUser!.name)/goals/\(goal!.id)/progressions/").childByAutoId().setValue(["name": goal!.progressions![i].name, "note": goal!.progressions![i].note, "date": goal!.progressions![i].date, "id": goal!.progressions![i].id])
            }
            
            //Return progression
            delegate?.getGoal(goal: goal!, delete: false, complete: false)
            
            navigationController?.popViewController(animated: true)
        }
    }
}
