//
//  ProdInfoCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 12/21/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class ProdInfoCell: UITableViewCell {
    
    
    @IBOutlet var lblQty: UILabel!
    
    @IBOutlet var lblProductDetail: UILabel!
    
    
    @IBOutlet var lblProductAmount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
