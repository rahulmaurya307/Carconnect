import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift

protocol RecProcDelegate {
    func reloadData(val : String!)
}

class OrderReciptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var cnstrntTableView: NSLayoutConstraint!
    var OrderDetailList : [OrderDetailModel] = [OrderDetailModel]()
    var orderID : String!
    
    @IBOutlet var viewAppliedPoints: UIView!
    @IBOutlet var CnstrntAppliedPoints: NSLayoutConstraint!
    @IBOutlet var myTableView: UITableView!
    @IBOutlet var lblTotalEarnedAmounts: UILabel!
    @IBOutlet var lblTotalPaidAmounts: UILabel!
    @IBOutlet var lblPointsAppliedAmount: UILabel!
    @IBOutlet var lblTotalAmount: UILabel!
    @IBOutlet var lblOrderID: UILabel!
    var myCartList : [MyCartModel] = [MyCartModel]()
    
    
    var amt : String!
    var totAmount : Int!  = 0
    var reservationId : String!
    var voucherList = [String]()
    var cal : Int! = 0
    var data1 = [String: Any]()
    var redeem : Int = 0
    var voucherVlue : Int = 0
    var awardBalWithRedeem : Int!
    
    var earnPoint : Int! = 0
    var totalamount : Int! = 0
    var vouchervalue : Int! = 0
    var couponvalue : Int! = 0
    var pointapplied : Int! = 0
    var paidamount : Int! = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let data : String = UserDefaults.standard.string(forKey: "data")!
        checkOutAction(jsonData: data)
        
        let data2 : String = UserDefaults.standard.string(forKey: "cartData")!
        getMyCartList(jsonData2 : data2)
        
        lblOrderID.text = "Your Order ID is : " + UserDefaults.standard.string(forKey: "orderId")!
    }
    
    func UITableView_Auto_Height()
    {
        if(self.myTableView.contentSize.height < self.myTableView.frame.height){
            cnstrntTableView.constant = self.myTableView.contentSize.height
        }
    }
    override func viewDidAppear (_ animated: Bool) {
        UITableView_Auto_Height();
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func btnOk(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "data")
        UserDefaults.standard.removeObject(forKey: "cartData")
        AppDelegate.getDelegate().resetView3()
       UserDefaults.standard.set(true, forKey: "order")
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = Bundle.main.loadNibNamed("OrderDetailCell", owner: self, options: nil)?.first as! OrderDetailCell
        cell2.lblProdQty.text = myCartList[indexPath.row].quantity + "x"
        cell2.lblProdDetail.text = myCartList[indexPath.row].productName
        cell2.lblProdAmount.text = myCartList[indexPath.row].price
        return cell2
        
    }
    
    func checkOutAction(jsonData : String){
        self.view.makeToastActivity(.center)
        let json = JSON.init(parseJSON: jsonData)
        print("My Json Data: \(json)")
        let data = json["data"].array!
        for i in data {
            let data2 = i.array![0]
            let totalTax = data2["totalTax"].stringValue
            let loyaltyAssociateId = data2["loyaltyAssociateId"].stringValue
            let totalAmount = data2["totalAmount"].int
            let redeemPoints = data2["redeemPoints"].intValue
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
                let awardBalanceWithRedeem = j["awardBalanceWithRedeem"].intValue
                let redeemPoint = j["redeemPoint"].intValue
                let voucherId = j["voucherId"].stringValue
                
                self.totalamount = totalAmount! + self.totalamount
                self.pointapplied = self.pointapplied + redeemPoint
                self.paidamount = self.paidamount +  balanceWithRedeem
                self.earnPoint = awardBalanceWithRedeem + self.earnPoint
                
                print("balanceWithRedeem : \(balanceWithRedeem)")
            }
        }
        self.lblTotalAmount.text = "₹ " + String(self.totalamount)
        self.lblPointsAppliedAmount.text = String(self.pointapplied)
        self.lblTotalPaidAmounts.text = "₹ " + String(self.paidamount)
        self.lblTotalEarnedAmounts.text = String(self.earnPoint)
        self.myTableView.reloadData()
        self.view.hideToastActivity()
    }
    
    func getMyCartList(jsonData2 : String)
    {
        self.view.makeToastActivity(.center)
        let json = JSON.init(parseJSON: jsonData2)
        let data = json["data"].array
        for i in data! {
            let myTrackRefList = JSON(i)
            let productList = myTrackRefList["productList"].array
            
            for dataModel in productList! {
                let cartId = dataModel["cartId"].stringValue
                let productId = dataModel["productId"].stringValue
                let quantity = dataModel["quantity"].stringValue
                let productName = dataModel["productName"].stringValue
                let productState = dataModel["productState"].stringValue
                let productImage = dataModel["productImage"].stringValue
                let price = dataModel["price"].stringValue
                let inventory = dataModel["inventory"].stringValue
                let productSold = dataModel["productSold"].stringValue
                
                var myInventory : Int?  = Int(inventory)
                var myProductSold : Int? = Int(productSold)
                
                if(myProductSold == nil){
                    myProductSold = 0
                }else if(myInventory == nil){
                    myInventory = 0
                }
                
                var itemLeft = myInventory! - myProductSold!
                let myImage = WebUrl.PRODUCT_IMAGE_URL + productImage
                self.myCartList.append(MyCartModel(cartId: cartId, productId: productId, quantity: quantity, productName: productName, productState: productState, productImage: myImage, price: price, inventory: inventory, productSold: productSold, itemLeft: itemLeft))
                
            }
            
        }
        self.myTableView.reloadData()
        self.view.hideToastActivity()
        
        
    }
}








