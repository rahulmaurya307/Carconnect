//
//  VoucherNameCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 12/21/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)

class VoucherNameCell: UITableViewCell {

    
    @IBOutlet var VoucherID: UILabel!
    @IBOutlet var btnSwitch: UISwitch!
    @IBOutlet var checkBoxView: Checkbox!
    @IBOutlet var lblVoucherName: UILabel!
    var delegate: VoucherClicked?
    var voucherIdviaCLicked : String!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnSwitch(_ sender: Any) {
        if btnSwitch.isOn{
            delegate?.vaucherClickedfunc(update:"ON",voucherID : VoucherID.text! )
         
        }else {
            delegate?.vaucherClickedfunc(update: "OFF", voucherID: VoucherID.text!)
            
        }
        
    }

    @IBAction func checkBoxView(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
protocol VoucherClicked {
    func vaucherClickedfunc(update : String, voucherID : String)
}
