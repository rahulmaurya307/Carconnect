//
//  PaymentCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 12/18/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class PaymentCell: UITableViewCell {

    @IBOutlet var lblProductAmount: UILabel!
    @IBOutlet var lblQty: UILabel!
    @IBOutlet var lblProductDetail: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
