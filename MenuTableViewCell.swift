//
//  MenuTableViewCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/13/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var MainImageView: UIImageView!
    @IBOutlet weak var MainLabel: UILabel!
    @IBOutlet weak var Mainlabel2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
