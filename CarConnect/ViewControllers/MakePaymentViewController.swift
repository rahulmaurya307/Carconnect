//
//  MakePaymentViewController.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 12/18/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import AlamofireImage


@available(iOS 10.0, *)
class MakePaymentViewController: UIViewController,UITableViewDataSource, VoucherDelegate {
    
    @IBOutlet var viewVoucher: UIView!
    @IBOutlet var viewPoints: UIView!
    @IBOutlet var view1: UIView!
    
    @IBOutlet var constrntVoucherView: NSLayoutConstraint!
    @IBOutlet var contrntPointView: NSLayoutConstraint!
    @IBOutlet var contrntTableView: NSLayoutConstraint!
    
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
    var myCartList : [MyCartModel] = [MyCartModel]()
    var voucherList = [String]()
    var cal : Int = 0
    var data1 = [String: Any]()
    var redeem : Int = 0
    var voucherVlue : Int = 0
    var balancePoint : Int = 0
    
 
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
    func UITableView_Auto_Height()
    {
        if(self.myTableView.contentSize.height < self.myTableView.frame.height){
           contrntTableView.constant = self.myTableView.contentSize.height
        }
    }
    override func viewDidAppear (_ animated: Bool) {
        UITableView_Auto_Height();
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func viewTest(_ sender: Any) {
    }
    
    @IBAction func btnPay(_ sender: Any) {
        self.checkOutAction()
        self.reserveOrder()

    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func vaucherList(selectVoucherList: [String]) {
        voucherList = selectVoucherList
        getVoucherDetails()
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
            getVoucherDetails()
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
        self.view.makeToastActivity(.center)
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
                self.view.hideToastActivity()
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
                        self.totAmount = self.totAmount - self.redeem
                        self.lbltotalPaybleAmount.text = "₹ " + String(self.totAmount)
                        self.txtFldEnterReedPoint.text = ""
                        
                    }else if (self.redeem == 0){
//                        let alert = UIAlertController(title: "Alert", message: "No Points Applied", preferredStyle: UIAlertControllerStyle.alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
                    }
                    
                     else if (self.voucherVlue != 0){
                        self.constrntVoucherView.isActive = true
                        self.viewVoucher.isHidden = false
                        self.lblVoucher.text = String(self.voucherVlue)
                        self.lblVoucher.isHidden = false
                         self.totAmount = self.totAmount - self.voucherVlue
                        self.lbltotalPaybleAmount.text = "₹ " + String(self.balancePoint)
                        self.myTableView.reloadData()
                    }
                    else if (self.voucherVlue == 0){
                        let alert = UIAlertController(title: "Alert", message: "No Voucher Applied", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                print(error)
                self.view.makeToast("Network Error")
            }
        }
    }
    
    func getVoucherDetails(){
        self.view.makeToastActivity(.center)
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
                self.view.hideToastActivity()
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
                        self.totAmount = self.totAmount - self.redeem
                        self.lbltotalPaybleAmount.text = "₹ " + String(self.totAmount)
                        
                    }else if (self.redeem == 0){
                        let alert = UIAlertController(title: "Alert", message: "No Points Applied", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                        
                    else if (self.voucherVlue != 0){
                        self.constrntVoucherView.isActive = true
                        self.viewVoucher.isHidden = false
                        self.lblVoucher.text = String(self.voucherVlue)
                        self.lblVoucher.isHidden = false
                        self.totAmount = self.totAmount - self.voucherVlue
                        self.lbltotalPaybleAmount.text = "₹ " + String(self.balancePoint)
                        self.myTableView.reloadData()
                    }
                    else if (self.voucherVlue == 0 ){
                        let alert = UIAlertController(title: "Alert", message: "No Voucher Applied", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    self.txtFldEnterReedPoint.text = ""
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                print(error)
                self.view.makeToast("Network Error")
            }
        }
    }
    
    
    func reserveOrder(){
        self.view.makeToastActivity(.center)
        
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
        print("url: \(WebUrl.RESERVE_CUSTOMER_ORDER_URL+"?token="+token)")
        
        //Alamofire Request
        Alamofire.request(WebUrl.RESERVE_CUSTOMER_ORDER_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                for i in data! {
                    self.reservationId = i["reserveId"].stringValue
                    print("Reservation Id: \(self.reservationId)")
                }
                let PaymentVc = self.storyboard?.instantiateViewController(withIdentifier: "Payment") as! Payment
                PaymentVc.reservationId = self.reservationId
                PaymentVc.toatlPaybleAmount = String(self.cal)
                
                self.present(PaymentVc, animated: true, completion: nil)
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                print(error)
                self.view.makeToast("Network Error")
            }
        }
    }
    
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
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }
    
}

