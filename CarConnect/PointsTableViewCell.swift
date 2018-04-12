//
//  PointsTableViewCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/27/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class PointsTableViewCell: UITableViewCell {

    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var ExpireLbl: UILabel!
    @IBOutlet weak var imgvwpointcell: UIImageView!
    @IBOutlet weak var ReedomLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var ExpireOnLbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
