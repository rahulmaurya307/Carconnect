//
//  EstoreDetailViewController.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/24/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift

class EstoreDetailViewController: UIViewController {
    var productId : String!
    var itemLeft : Int!
    var cart : String!
    
    @IBOutlet var btnPlus: UIButton!
    @IBOutlet var imgProduct: UIImageView!
    @IBOutlet var btnMinus: UIButton!
    
    @IBOutlet var txtvwNameDetails: UITextView!
    
    @IBOutlet var lblRate: UILabel!
    
    @IBOutlet var lblItemLeft: UILabel!
    
    
    @IBOutlet var ViewMinus: UIView!
    @IBOutlet var ViewPlus: UIView!
    
    @IBOutlet var txtvwDescription: UITextView!
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var btnAddCart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewPlus.makeCircular()
        ViewMinus.makeCircular()
        getDealerProductDetail()
    }
    
    
    var counter :Int! = 1
    @IBAction func btnPlus(_ sender: Any) {
        counter  = counter + 1
        if (counter > itemLeft){
            self.view.makeToast("Not enough product for add")
            print("My Counter If:\(counter)")
        }else{
            lblCount.text = String(counter)
             print("My Counter else:\(counter)")
        }
       
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func btnMinus(_ sender: Any) {
        counter = Int(lblCount.text!)
        if (lblCount.text == String(1)){
            return
        }else{
            self.counter = counter - 1
            lblCount.text = String(counter)
        }
        print("My Counter:\(counter)")
        
    }
    @IBAction func btnAddCart(_ sender: Any) {
        if(cart == String(false)){
            addCartAction();
        }
        else{
            updateCartAction();
        }
    }
    
    @IBAction func btnCart(_ sender: Any) {
        let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
        self.present(cartVC, animated: true, completion: nil)
    }
    
    func addCartAction(){
        
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyaltyId,"productId":productId,
                                         "quantity":lblCount.text]
        
        //Alamofire Request
        Alamofire.request(WebUrl.ADD_CART_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("Track Referal JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                self.view.makeToast("Succesfully Add to Cart.")
               
            }
                    
            //Network Error
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
            
            }
           
    }
    
    func updateCartAction(){
        var myCart : Int? = Int(cart!)
        var mylblCount : Int? = Int(lblCount.text!)
        
        if(myCart == nil){
            myCart = 0
        }else if(mylblCount == nil){
            mylblCount = 0
        }
        
        var quantity : Int? = myCart! + mylblCount!
        
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyaltyId,"productId":productId,
                                         "quantity":quantity]
        
        //Alamofire Request
        Alamofire.request(WebUrl.UPDATE_CART_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("Track Referal JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                self.view.makeToast("Succesfully Add to Cart.")
                
                }
                
            //Network Error
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
            
            
        }
    }
    
   
    func getDealerProductDetail(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyaltyId,"productId":productId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.PRODUCT_DETAIL_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("Track Referal JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                for i in data! {
                    let JsonObject = JSON(i)
                    let productDetail = JsonObject["productDetail"] as JSON
                    let Var = productDetail["transactionId"].stringValue
                    
            let transactionId = productDetail["transactionId"].stringValue
            let productId = productDetail["productId"].stringValue
            let productType = productDetail["productType"].stringValue
            let productName = productDetail["productName"].stringValue
            let productDescription = productDetail["productDescription"].stringValue
            let associateName = productDetail["associateName"].stringValue
            let productTypeId = productDetail["productTypeId"].stringValue
            let productSold = productDetail["productSold"].stringValue
            let productSpecification = productDetail["productSpecification"].stringValue
            let price = productDetail["price"].stringValue
            let couponBurn = productDetail["couponBurn"].stringValue
            let productPending = productDetail["productPending"].stringValue
            let productDelivered = productDetail["productDelivered"].stringValue
            self.cart = productDetail["cart"].stringValue
            let productTypeName = productDetail["productTypeName"].stringValue
            let productShipped = productDetail["productShipped"].stringValue
            let inventory = productDetail["inventory"].stringValue
            let productState = productDetail["productState"].stringValue
            let couponId = productDetail["couponId"].stringValue
            let productImage = productDetail["productImage"].stringValue
            let associateId = productDetail["associateId"].stringValue
                    
                    let myimage = WebUrl.PRODUCT_IMAGE_URL + productImage
                    let url = URL(string:myimage)!
                    self.imgProduct.af_setImage(withURL: url)
                    self.lblRate.text =  "₹ " + price
                    
                    var myInventory : Int?  = Int(inventory)
                    var myProductSold : Int? = Int(productSold)
                    
                    if(myProductSold == nil){
                        myProductSold = 0
                    }else if(myInventory == nil){
                        myInventory = 0
                    }
                    
                    self.itemLeft = myInventory! - myProductSold!
                    
                    if (self.itemLeft == 0){
                        self.btnAddCart.setTitle("OUT OF STOCK",for: .normal)
                        self.btnAddCart.isEnabled = false
                    }
                    self.lblItemLeft.text = String(self.itemLeft) + " Item Left"
                    self.txtvwNameDetails.text = productName
                    self.txtvwDescription.text = productDescription
                    
                    
                }
                
                
                
                
        }
                
            //Network Error
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
