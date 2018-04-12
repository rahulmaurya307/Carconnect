//
//  MakePaymentViewController.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 12/18/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//
let URLGetHash = "https://payu.herokuapp.com/get_hash"
import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import AlamofireImage


@available(iOS 10.0, *)
class MakePaymentViewController: UIViewController,UITabBarDelegate,UITableViewDataSource, VoucherDelegate {
    
    @IBOutlet var viewVoucher: UIView!
    @IBOutlet var viewPoints: UIView!
    @IBOutlet var view1: UIView!
    
    @IBOutlet var constrntVoucherView: NSLayoutConstraint!
    @IBOutlet var contrntPointView: NSLayoutConstraint!
    
    @IBOutlet var lbltotalPaybleAmount: UILabel!
    @IBOutlet var lblVoucher: UILabel!
    @IBOutlet var lblpoints: UILabel!
    @IBOutlet var lblPoints: UILabel!
    @IBOutlet var lblAmount: UILabel!
    
    @IBOutlet var txtFldEnterReedPoint: UITextField!
    @IBOutlet var myTableView: UITableView!
    
    var amt : String!
    var totAmount : Int!  = 0
    var reservationId : String!
    var webServiceResponse: PayUWebServiceResponse = PayUWebServiceResponse()
    var createRequest: PayUCreateRequest = PayUCreateRequest()
    var myCartList : [MyCartModel] = [MyCartModel]()
    var voucherList = [String]()
    var cal : Int = 0
    var data1 = [String: Any]()
    var redeem : Int = 0
    var voucherVlue : Int = 0
    var balancePoint : Int = 0
    
    lazy var paymentParams:PayUModelPaymentParams = {
        return PayUModelPaymentParams()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTotalPoint()
        constrntVoucherView.isActive = false
        contrntPointView.isActive = false
        viewPoints.isHidden = true
        viewVoucher.isHidden = true
        print(myCartList.count)
        view1.layer.borderWidth = 0.5
        
        for i in 0..<myCartList.count{
            var price  = Int(myCartList[i].price)!
            var qty  = Int(myCartList[i].quantity)!
            var sum = price * qty
            cal = cal + sum
        }
        lblAmount.text = "₹ " + String(cal)
        self.lbltotalPaybleAmount.text = "₹ " + String(cal)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func viewTest(_ sender: Any) {
    }
    
    @IBAction func btnPay(_ sender: Any) {
        
        //        let ORVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderReciptViewController") as! OrderReciptViewController
        //        //ORVC.delegate = self as! ClasifiedProcDelegate as! RecProcDelegate
        //        self.present(ORVC, animated: true, completion: nil)
        //
        //        let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderReciptViewController") as! OrderReciptViewController
        //        SecVC.myCartList = myCartList
        
        checkOutAction()
        reserveOrder()
        paymentParams.key = "PqvxqV"
        paymentParams.amount = String(cal)
        paymentParams.productInfo = "iPhone"
        paymentParams.firstName = "firstName"
        paymentParams.email = "xyz@gmail.com"
        setEnvironment(env: ENVIRONMENT_MOBILETEST)
        paymentParams.transactionID = self.generateTransectionId()
        paymentParams.surl = "https://payu.herokuapp.com/success"
        paymentParams.furl = "https://payu.herokuapp.com/failure"
        paymentParams.udf1 = "udf1"
        paymentParams.udf2 = "udf2"
        paymentParams.udf3 = "udf3"
        paymentParams.udf4 = "udf4"
        paymentParams.udf5 = "udf5"
        paymentParams.userCredentials = "PqvxqV:"+"xyz@gmail.com"
        
        let obj = PayUDontUseThisClass()
        obj.getPayUHashes(withPaymentParam: paymentParams, merchantSalt:"6SPh4Ulq") { (allHashes, hashString, errorMessage) in
            if (errorMessage == nil)
            {
                print(allHashes as Any)
                print(hashString as Any)
                self.paymentParams.hashes = allHashes
                self.getHashGet(paymentParams: self.paymentParams)
                self.callSDKWithHashes(allHashes:allHashes!, withError: errorMessage)
            }
            else
            {
                print (errorMessage as Any)
            }
            
        }
    }
    
    // MARK: Get Server Hash Key
    func callSDKWithHashes(allHashes: PayUModelHashes, withError errorMessage: String!) {
        if errorMessage == nil {
            paymentParams.hashes = allHashes
            let webServiceResponse = PayUWebServiceResponse()
            webServiceResponse.getPayUPaymentRelatedDetail(forMobileSDK: paymentParams) { (paymentDetail, errorMessage, array) in
                if errorMessage != nil
                {
                    print (errorMessage as Any)
                }else
                {
                    let stryBrd = UIStoryboard(name: "PUUIMainStoryBoard", bundle: nil)
                    let paymentOptionVC = stryBrd.instantiateViewController(withIdentifier: VC_IDENTIFIER_PAYMENT_OPTION) as? PUUIPaymentOptionVC
                    paymentOptionVC?.paymentParam = self.paymentParams
                    paymentOptionVC?.paymentRelatedDetail = paymentDetail
                    self.present(paymentOptionVC ?? UIViewController(), animated: true, completion: nil)
                }
            }
        }
        else {
            
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
    
    // MARK: setEnvironment
    
    func setEnvironment(env:String)
    {
        paymentParams.environment = ENVIRONMENT_MOBILETEST
        //        if (env == ENVIRONMENT_TEST){
        //            paymentParams.key = "gtKFFx"
        //        }
        //         else if (env == ENVIRONMENT_TEST){
        //            paymentParams.key = "gtKFFx"
        //        }
    }
    
    // MARK: Get Server Hash Key
    func getHashGet(paymentParams : PayUModelPaymentParams)
    {
        
        let parameters: [String: Any] = ["key" : paymentParams.key,"email" : paymentParams.email,"amount":paymentParams.amount,"firstname" : paymentParams.firstName,"txnid" :self.generateTransectionId(),"udf1" : paymentParams.udf1,"udf2" : paymentParams.udf2,"udf3" : paymentParams.udf3, "udf4" : paymentParams.udf4, "udf5" : paymentParams.udf5, "productinfo": paymentParams.productInfo,"user_credentials":paymentParams.userCredentials
        ]
        Alamofire.request(URLGetHash, method:.post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let payUHashes = PayUModelHashes()
            payUHashes.paymentHash = json["payment_hash"].string
            payUHashes.paymentRelatedDetailsHash = json["payment_related_details_for_mobile_sdk_hash"].string
            payUHashes.vasForMobileSDKHash = json["vas_for_mobile_sdk_hash"].string
            payUHashes.deleteUserCardHash = json["delete_user_card_hash"].string
            payUHashes.editUserCardHash = json["edit_user_card_hash"].string
            payUHashes.saveUserCardHash = json["save_user_card_hash"].string
            payUHashes.getUserCardHash = json["get_user_cards_hash"].string
            payUHashes.offerHash = json["check_offer_status_hash"].string
            
            self.callSDKWithHashes(allHashes:payUHashes, withError:"nil")
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.makeToast("Network Error")
                
            }
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func vaucherList(selectVoucherList: [String]) {
        voucherList = selectVoucherList
        checkOutAction()
        print("Voucher List: \(voucherList)")
    }
    
    @IBAction func btnSelectVoucher(_ sender: Any) {
        
        let VVC = self.storyboard?.instantiateViewController(withIdentifier: "VoucherViewController") as! VoucherViewController
        VVC.delegate = self
        self.present(VVC, animated: true, completion: nil)
    }
    @IBAction func btnApply(_ sender: Any) {
        if(txtFldEnterReedPoint.text?.isEmpty)!{
            self.view.makeToast("Please Enter Reedeem Points")
        }else{
            checkOutAction()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = Bundle.main.loadNibNamed("ProdInfoCell", owner: self, options: nil)?.first as! ProdInfoCell
        
        cell2.lblQty.text = myCartList[indexPath.row].quantity + "x"
        cell2.lblProductDetail.text = myCartList[indexPath.row].productName!
        print("Heloo Printt : \(myCartList[indexPath.row].productName!)")
        
        var price : Int = Int(myCartList[indexPath.row].price)!
        var quantity : Int = Int(myCartList[indexPath.row].quantity)!
        var totalAmount = quantity * price
        cell2.lblProductAmount.text = "₹ " + String(totalAmount)
        amt = String(totalAmount)
        return cell2
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 300;//Choose your custom row height
    }
    
    
    func checkOutAction(){
        
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        var transactions = [Any]()
        
        for i in 0..<myCartList.count{
            transactions.append(["price":myCartList[i].price, "quantity": myCartList[i].quantity, "productId" : myCartList[i].productId])
        }
        
        let parameters: [String: Any] = ["loyaltyId":loyaltyId,
                                         "redeemPoint": txtFldEnterReedPoint.text!,
                                         "transactions" : transactions
        ]
        
        print(parameters)
        
        //Alamofire Request
        Alamofire.request(WebUrl.CHECK_OUT_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let status = json["status"].stringValue
                if (status == WebUrl.SUCCESS_CODE){
                    let data = json["data"].array
                    UserDefaults.standard.set(String(describing: json), forKey: "data") //setObject
                    for i in data! {
                        let data2 = i.array![0]
                        let totalTax = data2["totalTax"].stringValue
                        let loyaltyAssociateId = data2["loyaltyAssociateId"].stringValue
                        let totalAmount = data2["totalAmount"].stringValue
                        let redeemPoints = data2["redeemPoints"].stringValue
                        let loyaltyUserTierType = data2["loyaltyUserTierType"].stringValue
                        let loyaltyId = data2["loyaltyId"].stringValue
                        
                        print("totalTax: \(totalTax)")
                        print("loyaltyAssociateId: \(loyaltyAssociateId)")
                        print("totalAmount: \(totalAmount)")
                        
                        let transactions = data2["transactions"].array
                        print("transactions: \(transactions)")
                        
                        var redeemPnt : Int? = nil
                        
                        for j in transactions!{
                            let productId = j["productId"].stringValue
                            let additionalInfo = j["additionalInfo"].stringValue
                            let minRedeemPoint = j["minRedeemPoint"].stringValue
                            let txnTier = j["txnTier"].stringValue
                            let maxRedeemPoint = j["maxRedeemPoint"].stringValue
                            let txnTax = j["txnTax"].stringValue
                            let couponName = j["couponName"].stringValue
                            let redeemValue = j["redeemValue"].stringValue
                            let couponCode = j["couponCode"].stringValue
                            let couponId = j["couponId"].stringValue
                            let activationDate = j["activationDate"].stringValue
                            let couponValue = j["couponValue"].stringValue
                            let voucherName = j["voucherName"].stringValue
                            let txnAmount = j["txnAmount"].stringValue
                            let balanceWithoutRedeem = j["balanceWithoutRedeem"].stringValue
                            let voucherValue = j["voucherValue"].intValue
                            let expiryDate = j["expiryDate"].stringValue
                            let txnId = j["txnId"].stringValue
                            let serviceName = j["serviceName"].stringValue
                            let txnPartnerTransaction = j["txnPartnerTransaction"].stringValue
                            let quantity = j["quantity"].stringValue
                            let awardBalanceWithoutRedeem = j["awardBalanceWithoutRedeem"].stringValue
                            let txnPartnerId = j["txnPartnerId"].stringValue
                            let txnType = j["txnType"].stringValue
                            let price = j["price"].stringValue
                            let balanceWithRedeem = j["balanceWithRedeem"].intValue
                            self.balancePoint = self.balancePoint + balanceWithRedeem
                            let awardBalanceWithRedeem = j["awardBalanceWithRedeem"].stringValue
                            let redeemPoint = j["redeemPoint"].intValue
                            let voucherId = j["voucherId"].stringValue
                            
                            self.redeem = self.redeem + redeemPoint
                            print("MyRedeem Points: \(self.redeem)")
                            
                            self.voucherVlue = self.voucherVlue + voucherValue
                            print("My voucherVlue : \(self.redeem)")
                            
                            self.totAmount = self.cal
                            
                        }
                    }
                    if(self.redeem != 0){
                        self.contrntPointView.isActive = true
                        self.viewPoints.isHidden = false
                        self.lblpoints.text = String(self.redeem)
                        self.lblpoints.isHidden = false
                        //self.totAmount = self.totAmount - self.redeem
                    }
                        
                    else if (self.voucherVlue != 0){
                        self.constrntVoucherView.isActive = true
                        self.viewVoucher.isHidden = false
                        self.lblVoucher.text = String(self.voucherVlue)
                        self.lblVoucher.isHidden = false
                        // self.totAmount = self.totAmount - self.voucherVlue
                        self.lbltotalPaybleAmount.text = "₹ " + String(self.balancePoint)
                        self.myTableView.reloadData()
                    }
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                print(error)
                self.view.makeToast("Network Error")
            }
        }
    }
    
    
    func reserveOrder(){
        
        
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        var transactions = [Any]()
        
        
        for i in 0..<myCartList.count{
            transactions.append(["price":myCartList[i].price, "quantity": myCartList[i].quantity, "productId" : myCartList[i].productId])
        }
        let parameters: [String: Any] = ["loyaltyId":loyaltyId,
                                         "redeemPoint": txtFldEnterReedPoint.text!,
                                         "transactions" : transactions
        ]
        
        print(parameters)
        
        //Alamofire Request
        Alamofire.request(WebUrl.RESERVE_CUSTOMER_ORDER_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    self.reservationId = i["reserveId"].stringValue
                    self.confirmOrder()
                }
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                print(error)
                self.view.makeToast("Network Error")
            }
        }
    }
    
    func confirmOrder() {
        
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        let parameters: [String: Any] = ["loyaltyId":loyaltyId, "reservationId" : self.reservationId]
        
        print(parameters)
        
        //Alamofire Request
        Alamofire.request(WebUrl.CONFIRM_CUSTOMER_ORDER_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    var orderId = i["orderId"].stringValue
                    UserDefaults.standard.set(orderId, forKey: "orderId")
                    self.deleteCart(orderId: orderId)
                }
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                print(error)
                self.view.makeToast("Network Error")
            }
        }
    }
    
    func deleteCart(orderId : String){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        let parameters: [String: Any] = ["loyaltyId":loyaltyId, "orderId" : orderId]
        
        print(parameters)
        
        //Alamofire Request
        Alamofire.request(WebUrl.CLEAR_CART+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
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
                print(error)
                self.view.makeToast("Network Error")
            }
        }
    }
    ///////////*****************Function Start to Get Total Points *****************///////////
    func getTotalPoint(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyaltyId]
        
        
        //Alamofire Request
        Alamofire.request(WebUrl.AVAILABLE_POINT_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                for i in data! {
                    let balancePoint = i["balancePoint"] .stringValue
                    self.lblPoints.text = "Your Available Point : \(balancePoint)"
                }
                }
            //Network Error
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
    /*****************Function End to Get Total Points *****************///////////
    
}

