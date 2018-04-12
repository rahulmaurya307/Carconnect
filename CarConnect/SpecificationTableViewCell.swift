//
//  SpecificationTableViewCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/3/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class SpecificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var SpecName : UILabel!
    @IBOutlet weak var SpecVal : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
