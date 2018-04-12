//
//  MyCartCell.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/27/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit
import Toast_Swift
import AlamofireImage
import Alamofire

class MyCartCell: UITableViewCell {
    
    var itemLeft : Int!
    @IBOutlet var view: UIView!
    @IBOutlet var viewP: UIView!
    @IBOutlet var viewM: UIView!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var txtvwCart: UITextView!
    @IBOutlet var imgCart: UIImageView!
    @IBOutlet var lblId: UILabel!
   
    @IBOutlet var productID: UILabel!
    @IBOutlet var lblProductQuantity: UILabel!
    var delegate: CartDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewM.makeCircular()
        viewP.makeCircular()
        lblId.isHidden = true
        productID.isHidden = true
        
    }

    var counter : Int = 0
    @IBAction func btnPlus(_ sender: Any) {
        counter = Int(lblProductQuantity.text!)!
        counter  = counter + 1
        if (counter > itemLeft){
            self.view.makeToast("Not enough product for add")
            print("My Counter If:\(counter)")
        }else{
            lblProductQuantity.text = String(counter)
            print("My Counter else:\(counter)")
        }
        
}
    
@IBAction func btnMinus(_ sender: Any) {
        counter = Int(lblProductQuantity.text!)!
        if (lblProductQuantity.text == String(1)){
            return
        }else{
            self.counter = counter - 1
            lblProductQuantity.text = String(counter)
        }
        print("My Counter:\(counter)")
      
}
    
@IBAction func btnDelete(_ sender: UIButton) {
    delegate?.valueLable(update: "delete", cartId: lblId.text!, quantity: "")
    print("DELETE")
}
    
    @IBAction func btnUpdate(_ sender: Any) {
        delegate?.valueLable(update: "update", cartId: productID.text!, quantity: lblProductQuantity.text!)
        print("UPDATE")
}
}

protocol CartDelegate {
    func valueLable(update : String, cartId : String, quantity : String)
}
