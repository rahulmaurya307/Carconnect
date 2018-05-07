//
//  Payment.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 4/6/18.
//  Copyright © 2018 Aritron Technologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import AlamofireImage

class Payment: UIViewController {
    var messege : String?
    var toatlPaybleAmount : String?
    
    @IBOutlet var btnPayment: UIButton!
    var reservationId : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("paymentvc reservationId : \(reservationId)")
        print("toatl PaybleAmount : \(toatlPaybleAmount)")
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnBack(_ sender: Any) {
        toatlPaybleAmount = String(0)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnPayment(_ sender: Any) {
        
        let mobile =  UserDefaults.standard.string(forKey: "mobile") //setObject
        let email = UserDefaults.standard.string (forKey: "email") //setObject
        let name = UserDefaults.standard.string(forKey: "name")
        let totalAmount = self.toatlPaybleAmount
        
        PayUServiceHelper.sharedManager().getPayment(self, email, mobile, name, totalAmount, generateTransectionId(), didComplete: { (dict, error) in
            if let error = error {
                print("Error")
            }else {
                    print("Sucess")
                    self.confirmOrder()
            }
        }) { (error) in
            print("Payment Process Breaked")
        }
        
    }
    
    // MARK:  Generate TransactionId
    
    func generateTransectionId() -> String{
        var currentTime:NSString =  "\(NSDate().timeIntervalSince1970)" as NSString
        currentTime = currentTime.substring(with: NSMakeRange(0, 8)) as NSString
        let letters : NSString = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let len = UInt32(letters.length)
        
        var randomString = ""
        for _ in 0 ..< 10 {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        let transactionID = (currentTime as String)
        return transactionID
    }
    
    func confirmOrder() {
        
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        let parameters: [String: Any] = ["loyaltyId":loyaltyId, "reservationId" : self.reservationId]
        
        print(parameters)
        
        //Alamofire Request
        Alamofire.request(WebUrl.CONFIRM_CUSTOMER_ORDER_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    var orderId = i["orderId"].stringValue
                    UserDefaults.standard.set(orderId, forKey: "orderId")
                    self.deleteCart(orderId: orderId)
                }
    let OrderReciptVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderReciptViewController") as! OrderReciptViewController
        self.present(OrderReciptVC, animated: true, completion: nil)
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                print(error)
                self.view.makeToast("Network Error")
            }
        }
    }
    
    func deleteCart(orderId : String){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        let parameters: [String: Any] = ["loyaltyId":loyaltyId, "orderId" : orderId]
        
        print(parameters)
        
        //Alamofire Request
        Alamofire.request(WebUrl.CLEAR_CART+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                //
                //                for i in data! {
                //                    var orderId = i["orderId"].stringValue
                //                }
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                print(error)
                self.view.makeToast("Network Error")
            }
        }
    }



}
