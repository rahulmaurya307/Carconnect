//
//  UsedCarCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/25/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class UsedCarCell: UITableViewCell {

    @IBOutlet weak var Placelbl5: UILabel!
    @IBOutlet weak var Kmlbl4: UILabel!
    @IBOutlet weak var Yearlbl3: UILabel!
    @IBOutlet weak var CarNamelbl1: UILabel!
    @IBOutlet weak var UsecarImageView: UIImageView!
    @IBOutlet weak var Rslbl2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
