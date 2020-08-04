//
//  FollowedGoalCellTableViewCell.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/27/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit

class FollowedGalaxyCell: UITableViewCell {

    @IBOutlet weak var goalName: UILabel!
    @IBOutlet weak var goalDesc: UITextView!
    @IBOutlet weak var galaxyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
