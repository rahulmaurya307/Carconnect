//
//  Dealer_PartnerCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/23/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class Dealer_PartnerCell: UITableViewCell {

    @IBOutlet weak var lblStockDl_Pt: UILabel!
    @IBOutlet weak var lblRateNameDl_Pt: UILabel!
    
    @IBOutlet weak var lblProdNameDl_Pt: UITextView!
    @IBOutlet weak var ImageViewDl_Pt: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
