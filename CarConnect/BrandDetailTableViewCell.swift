//
//  BrandDetailTableViewCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/30/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class BrandDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var LblCarName: UILabel!
    @IBOutlet weak var LblEngine: UILabel!
    @IBOutlet weak var LblShowroom: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
