//
//  RoadSideAssistanceTableViewCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/26/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class RoadSideAssistanceTableViewCell: UITableViewCell {
    var mobNoAssistance : String!
    
    @IBOutlet weak var ImageViewRoadassCell: UIImageView!
    @IBOutlet weak var RoadLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func btnTabForCall(_ sender: Any) {
        print(mobNoAssistance)
        if let url = URL(string: "tel://"+mobNoAssistance), UIApplication.shared.canOpenURL(url) {
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
