//
//  BrowseTableViewCell.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/18/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit

class BrowseTableViewCell: UITableViewCell {

    @IBOutlet weak var goalNameText: UILabel!
    @IBOutlet weak var goalDescriptionText: UITextView!
    @IBOutlet weak var galaxyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //No selection style.
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
