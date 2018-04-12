//
//  CouponCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/24/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class CouponCell: UITableViewCell {

    @IBOutlet weak var lblCouponName: UILabel!
    @IBOutlet weak var lblExpirydate: UILabel!
    @IBOutlet weak var lblCouponCode: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
