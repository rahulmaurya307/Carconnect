//
//  BrandHelplineTableViewCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/26/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class BrandHelplineTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewBrand: UIImageView!
    @IBOutlet weak var LblCarName: UILabel!
    @IBOutlet weak var LblMobNo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnBrandHelpline(_ sender: Any) {
        print(LblMobNo.text)
        if let url = URL(string: "tel://"+LblMobNo.text!), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
