//
//  OrderSummaryCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/23/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class OrderSummaryCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblRedeemPoint: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    
    @IBOutlet weak var lblEarnedPoint: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
