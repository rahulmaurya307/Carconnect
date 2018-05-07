import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift

class OrderDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var OrderDetailList : [OrderDetailModel] = [OrderDetailModel]()
    var orderID : String!
    
    var earnPoint : Int! = 0
    var totalamount : Int! = 0
    var vouchervalue : Int! = 0
    var couponvalue : Int! = 0
    var pointapplied : Int! = 0
    var paidamount : Int! = 0
    
    @IBOutlet var cnstrntTableView: NSLayoutConstraint!
    @IBOutlet var myTableView: UITableView!
    @IBOutlet var lblTotalEarnedAmounts: UILabel!
    @IBOutlet var lblTotalPaidAmounts: UILabel!
    @IBOutlet var lblPointsAppliedAmount: UILabel!
    @IBOutlet var lblTotalAmount: UILabel!
    @IBOutlet var lblOrderID: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        print("token : \(token)")
         print("loyltyId : \(loyltyId)")
        print("orderID : \(orderID)")
        getOrderDetail()
        lblOrderID.text = "Order ID : " + orderID
    }
   
    func UITableView_Auto_Height()
    {
        if(self.myTableView.contentSize.height < self.myTableView.frame.height){
            cnstrntTableView.constant = self.myTableView.contentSize.height
            
        }
    }
    override func viewDidAppear (_ animated: Bool) {
        print("viewDidAppear")
        //UITableView_Auto_Height()
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderDetailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = Bundle.main.loadNibNamed("OrderDetailCell", owner: self, options: nil)?.first as! OrderDetailCell
        cell2.lblProdQty.text = OrderDetailList[indexPath.row].quantity + "X"
        cell2.lblProdAmount.text = OrderDetailList[indexPath.row].totalAmount
        cell2.lblProdDetail.text = OrderDetailList[indexPath.row].productName
        cell2.lblOrderStatus.text = "Order Track Status (" + OrderDetailList[indexPath.row].orderState + ")"
        return cell2
        
    }
    
    //func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  //  {
  //      return 100;//Choose your custom row height
   // }
    func getOrderDetail(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyltyId, "orderId":orderID ]
        
        //Alamofire Request
        Alamofire.request(WebUrl.ORDER_DETAIL_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let orderList = i["orderList"].array // Read Json Object
                    
                    for dataModel in orderList! {      // Parse Json Array
                        let productImage = dataModel["productImage"].stringValue
                        let couponValue = dataModel["couponValue"].stringValue
                        let productId = dataModel["productId"].stringValue
                        let productType = dataModel["productType"].stringValue
                        let voucherValue = dataModel["voucherValue"].stringValue
                        let productName = dataModel["productName"].stringValue
                        let orderId = dataModel["orderId"].stringValue
                        let orderDate = dataModel["orderDate"].stringValue
                        let quantity = dataModel["quantity"].stringValue
                        let loyaltyId = dataModel["loyaltyId"].stringValue
                        let partnerProduct = dataModel["partnerProduct"].stringValue
                        let price = dataModel["price"].stringValue
                        let orderState = dataModel["orderState"].stringValue
                        let pointRedeem = dataModel["pointRedeem"].stringValue
                        let paidAmount = dataModel["paidAmount"].stringValue
                        let redeemPointsValue = dataModel["redeemPointsValue"].stringValue
                        let totalAmount = dataModel["totalAmount"].stringValue
                        let productAssociateId = dataModel["productAssociateId"].stringValue
                        let voucherId = dataModel["voucherId"].stringValue
                        let couponId = dataModel["couponId"].stringValue
                        let loyaltyOrderId = dataModel["loyaltyOrderId"].stringValue
                        let pointEarn = dataModel["pointEarn"].stringValue
                        
                        self.OrderDetailList.append(OrderDetailModel(orderId: orderId, productId: productId, productName: productName, quantity: quantity, price: price, totalAmount: totalAmount, productImage: productImage, couponValue: couponValue, voucherValue: voucherValue, pointRedeem: pointRedeem, pointEarn: pointEarn, paidAmount: paidAmount, orderDate: orderDate, orderState: orderState))
                        
                        
                        
                        self.earnPoint = Int(pointEarn)! + self.earnPoint
                        self.totalamount = Int(totalAmount)! + self.totalamount
                        self.vouchervalue = self.vouchervalue + Int(voucherValue)!
                        self.couponvalue = self.couponvalue + Int(couponValue)!
                        self.pointapplied = self.pointapplied + Int(redeemPointsValue)!
                        self.paidamount = self.paidamount +  Int(paidAmount)!
                        
                    }
                    
                    self.lblTotalAmount.text = "₹ " + String(self.totalamount)
                    self.lblPointsAppliedAmount.text = String(self.pointapplied)
                    self.lblTotalPaidAmounts.text = "₹ " + String(self.paidamount)
                    self.lblTotalEarnedAmounts.text = String(self.earnPoint)
                    
                    
                }
               
                self.myTableView.reloadData()
                let message = json["message"].stringValue
                self.UITableView_Auto_Height()
                
                }
            
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }
}

