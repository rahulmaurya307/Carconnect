//
//  MyCarTableViewCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/17/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class MyCarTableViewCell: UITableViewCell {

    @IBOutlet weak var MyCarCellImageView: UIImageView!
    @IBOutlet weak var MyCarCellLabel1: UILabel!
    @IBOutlet weak var MyCarCellLabel2: UILabel!
    @IBOutlet weak var CardViewCell: UIView!

    
    @IBInspectable var cornerRadius: CGFloat = 2
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.2
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CardViewCell.layer.cornerRadius = cornerRadius
        CardViewCell.layer.masksToBounds = false
        CardViewCell.layer.shadowColor = shadowColor?.cgColor
        CardViewCell.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        CardViewCell.layer.shadowOpacity = shadowOpacity    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
