//
//  NewsCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/25/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    
    @IBOutlet weak var NewsCellImageView: UIImageView!
    @IBOutlet weak var NewsLbl1: UILabel!
    @IBOutlet weak var NewsLbl2: UILabel!
    
    @IBAction func ReadMoreBtn(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

