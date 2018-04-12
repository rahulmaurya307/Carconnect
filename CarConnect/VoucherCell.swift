//
//  VoucherCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/24/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class VoucherCell: UITableViewCell {
    @IBOutlet weak var lblVoucherName: UILabel!
    @IBOutlet weak var lblVoucherDetail: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

