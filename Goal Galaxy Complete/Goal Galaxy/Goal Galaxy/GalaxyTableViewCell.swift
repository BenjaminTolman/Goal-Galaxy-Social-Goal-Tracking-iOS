//
//  GalaxyTableViewCell.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/19/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit

class GalaxyTableViewCell: UITableViewCell {

    @IBOutlet weak var progressName: UILabel!
    @IBOutlet weak var progressDate: UILabel!
    @IBOutlet weak var progressNote: UITextView!
    
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
