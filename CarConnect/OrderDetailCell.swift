//
//  OrderDetailCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 12/22/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class OrderDetailCell: UITableViewCell {

    @IBOutlet var lblOrderStatus: UILabel!
    @IBOutlet var lblProdAmount: UILabel!
    @IBOutlet var lblProdDetail: UILabel!
    @IBOutlet var lblProdQty: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
