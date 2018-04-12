//
//  myCell1.swift
//  SegmentUitable
//
//  Created by Saurabh Sharma on 11/7/17.
//  Copyright © 2017 Rahul. All rights reserved.
//

import UIKit

class Points: UITableViewCell {

    @IBOutlet weak var expiresView: UIView!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var expireImageView: UIImageView!
    @IBOutlet weak var lblActivationDate: UILabel!
    
    @IBOutlet weak var lblEarnPoint: UILabel!
    @IBOutlet weak var lblRedeemPoint: UILabel!
    @IBOutlet weak var lblExpiryDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
