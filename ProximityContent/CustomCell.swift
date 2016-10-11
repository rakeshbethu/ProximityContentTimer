//
//  CustomCell.swift
//  ProximityContent
//
//  Created by Rakesh Bethu on 10/11/16.
//  Copyright © 2016 Estimote, Inc. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet var beaconName: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var duration: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization Code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
