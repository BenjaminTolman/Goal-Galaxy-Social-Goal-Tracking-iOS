//
//  FollowedUserTableViewCell.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/26/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit

class FollowedUserTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var numberOfGoals: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

}
