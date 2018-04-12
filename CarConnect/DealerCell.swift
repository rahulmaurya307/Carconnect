//
//  DealerCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/14/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class DealerCell: UITableViewCell {

    @IBOutlet weak var imageDealerCell: UIImageView!
    
    @IBOutlet weak var lbl1DealerCell: UILabel!
    
    @IBOutlet weak var lbl2DealerCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
