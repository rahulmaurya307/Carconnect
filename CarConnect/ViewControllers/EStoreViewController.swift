
import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
import Toast_Swift


@objc class EStoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var myTableConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var View3: UIView!
    @IBOutlet weak var myTablview: UITableView!
    @IBOutlet weak var mySegmentControll: UISegmentedControl!
     var dealerProductList : [DealerProductsModel] = [DealerProductsModel]()
    var orderSummaryList : [OrderSummaryModel] = [OrderSummaryModel]()
    var CouponList : [CouponModel] = [CouponModel]()
    var VoucherList : [VoucherModel] = [VoucherModel]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.isDealerClick = true
        getDealerProduct()
        
        
        View3.isHidden = false
    }
    var ispartnerclick=false
    @IBAction func btnpartner(_ sender: Any) {
        dealerProductList.removeAll()
        getPartnerProduct()
        ispartnerclick=true
        isDealerClick=false
        isOrderClick=false
     
        myTablview.reloadData()
        
    }
    
    var isDealerClick=false
    @IBAction func btnDealer(_ sender: Any) {
   
        dealerProductList.removeAll()
        getDealerProduct()
        isDealerClick = true
        ispartnerclick=false
        isOrderClick=false
  
        myTablview.reloadData()
        
    }
    var isOrderClick=false
    @IBAction func btnOrder(_ sender: Any) {
        orderSummaryList.removeAll()
        getOrederSummary()
        isDealerClick = false
        ispartnerclick=false
        isOrderClick=true
        myTablview.reloadData()
    }

    @IBAction func MySegmentAction(_ sender: Any) {

        switch (mySegmentControll.selectedSegmentIndex) {
        case 0:
            myTableConstraint.constant = 42
            dealerProductList.removeAll()
            getDealerProduct()
            myTablview.reloadData()
            View3.isHidden = false
            break
        case 1:
            myTableConstraint.constant = 2
            CouponList.removeAll()
            getCoupons()
            myTablview.reloadData()
            
            View3.isHidden = true
            break
        case 2:
            VoucherList.removeAll()
            getVoucher()
            myTableConstraint.constant = 2
            myTablview.reloadData()
            View3.isHidden = true
            break
        default:
            break
        }
        
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
                let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
        self.present(cartVC, animated: true, completion: nil)
    }
    
    @IBAction func ToggleSideMenu(_ sender: Any) {
        toggleSideMenuView()
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch (mySegmentControll.selectedSegmentIndex) {
        case 0:
            if ispartnerclick
            {
                returnValue = dealerProductList.count
            }
            else if isDealerClick
            {
                returnValue = dealerProductList.count
            }
            
            else if isOrderClick
            {
                returnValue = orderSummaryList.count
            }
            
            break
        case 1:
          returnValue = CouponList.count
           break
        case 2:
            returnValue = VoucherList.count
            break
        default:
            break
        }
        return returnValue
    }
    
@objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var returnValue : UITableViewCell?
        switch (mySegmentControll.selectedSegmentIndex) {
        case 0:
            if isDealerClick{
                
                //var myProductSold
                let Dealer_PartnerCell = Bundle.main.loadNibNamed("Dealer_PartnerCell", owner: self, options: nil)?.first as! Dealer_PartnerCell
                
                let url = URL(string: dealerProductList[indexPath.row].productImage)!
                Dealer_PartnerCell.ImageViewDl_Pt.af_setImage(withURL: url)

                
                var newInventory : Int?  = Int(dealerProductList[indexPath.row].inventory)
                var newProductSold : Int? = Int(dealerProductList[indexPath.row].productSold)
                
                if(newProductSold == nil){
                    newProductSold = 0
                }else if(newInventory == nil){
                    newInventory = 0
                }
                
                let stockFinal = newInventory! - newProductSold!
                print(stockFinal)
                Dealer_PartnerCell.lblProdNameDl_Pt.text = dealerProductList[indexPath.row].productName
                Dealer_PartnerCell.lblRateNameDl_Pt.text = "₹" + dealerProductList[indexPath.row].price
                if(stockFinal == 0){
                    Dealer_PartnerCell.lblStockDl_Pt.text = "( Out Of Stock )"
                }
                
            return Dealer_PartnerCell
            }
            
            if ispartnerclick{
                let Dealer_PartnerCell = Bundle.main.loadNibNamed("Dealer_PartnerCell", owner: self, options: nil)?.first as! Dealer_PartnerCell
                
                let url = URL(string: dealerProductList[indexPath.row].productImage)!
                Dealer_PartnerCell.ImageViewDl_Pt.af_setImage(withURL: url)
                
                Dealer_PartnerCell.lblProdNameDl_Pt.text = dealerProductList[indexPath.row].productName
                Dealer_PartnerCell.lblRateNameDl_Pt.text = "₹" + dealerProductList[indexPath.row].price
                Dealer_PartnerCell.lblStockDl_Pt.text = dealerProductList[indexPath.row].productSold
                return Dealer_PartnerCell

            }
            
            if isOrderClick{
                let OrderSummaryCell = Bundle.main.loadNibNamed("OrderSummaryCell", owner: self, options: nil)?.first as! OrderSummaryCell
                OrderSummaryCell.lblOrderId.text = orderSummaryList[indexPath.row].orderId
                OrderSummaryCell.lblEarnedPoint.text = orderSummaryList[indexPath.row].pointEarn
                OrderSummaryCell.lblRedeemPoint.text = orderSummaryList[indexPath.row].pointRedeem
                OrderSummaryCell.lblAmount.text = "₹" + orderSummaryList[indexPath.row].oAmount
                OrderSummaryCell.lblDate.text = orderSummaryList[indexPath.row].invoiceDate
                return OrderSummaryCell
                
                
            }
           
            
        case 1:
            let CouponCell = Bundle.main.loadNibNamed("CouponCell", owner: self, options: nil)?.first as! CouponCell
             CouponCell.lblCouponName.text = CouponList[indexPath.row].couponName
             CouponCell.lblCouponCode.text = CouponList[indexPath.row].couponCode
             CouponCell.lblExpirydate.text = "Expiry Date" + CouponList[indexPath.row].expiryDate
            return CouponCell
        case 2:
            let VoucherCell = Bundle.main.loadNibNamed("VoucherCell", owner: self, options: nil)?.first as! VoucherCell
            VoucherCell.lblVoucherName.text = VoucherList[indexPath.row].voucherName
            VoucherCell.lblVoucherDetail.text = VoucherList[indexPath.row].voucherDescription
            return VoucherCell
        default:
            break
        }
    return returnValue!
    }
    
    @objc func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (mySegmentControll.selectedSegmentIndex) {
        case 0:
            if ispartnerclick
            {
                let EstoreDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "EstoreDetailViewController") as! EstoreDetailViewController
                EstoreDetailVC.productId = dealerProductList[indexPath.row].productId
                
                self.present(EstoreDetailVC, animated: true, completion: nil)
                break
                
            }
                
            else if isDealerClick
            {
                let EstoreDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "EstoreDetailViewController") as! EstoreDetailViewController
              EstoreDetailVC.productId = dealerProductList[indexPath.row].productId
              
                self.present(EstoreDetailVC, animated: true, completion: nil)
                break
            }
                
            else if isOrderClick
            {
                
                let orderVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailViewController") as! OrderDetailViewController
                orderVC.orderID = orderSummaryList[indexPath.row].orderId
                
                self.present(orderVC, animated: true, completion: nil)
                break
            }
        case 1:
                break
        case 2:
                break
        default:
            break
        }
        
    }
    
@objc func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch (mySegmentControll.selectedSegmentIndex) {
        case 0:
            if ispartnerclick
            {
                return 290.0
            }
            
            else if isDealerClick
            {
                return 290.0
                
            }
            
           else if isOrderClick
            {
                return 180.0
                
            }
        case 1:
            return 280.0
            
        case 2:
           
            return 160
            
        default:
            break
        }
        
        return 0
    }
    
/*****************Function Start to Get Order Summary *****************///////////
     @objc func getOrederSummary(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["token":token,"loyaltyId":loyaltyId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.TRANSCATION_HISTORY+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let myOrderList = JSON(i)
                    let orderList = myOrderList["orderList"].array
                    for dataModel in orderList! {
                        let placeBy = dataModel["placeBy"].stringValue
                        let orderId = dataModel["orderId"].stringValue
                        let pointEarn = dataModel["pointEarn"].stringValue
                        let pointRedeem = dataModel["pointRedeem"].stringValue
                        let oAmount = dataModel["oAmount"].stringValue
                        let invoiceDate = dataModel["invoiceDate"].stringValue
                        self.orderSummaryList.append(OrderSummaryModel(placeBy: placeBy, orderId: orderId, pointEarn: pointEarn, pointRedeem: pointRedeem, oAmount: oAmount, invoiceDate: invoiceDate))
                        
                    }
                    
                    self.myTablview.reloadData()
                    
                }
                }
                
            //Network Error
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
///////////*****************Function End to get Order Summary *****************/
    
    
/*****************Function Start to Get Partner Products *****************///////////
    @objc func getPartnerProduct(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["token":token]
        
        //Alamofire Request
        Alamofire.request(WebUrl.PARTNER_PRODUCT_LIST+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let myPartnerList = JSON(i)
                    let associatePartnerProductList = myPartnerList["associatePartnerProductList"].array
                    for dataModel in associatePartnerProductList! {
                        let productId = dataModel["productId"].stringValue
                        let productName = dataModel["productName"].stringValue
                        let price = dataModel["price"].stringValue
                        let productImage = dataModel["productImage"].stringValue
                        let productDescription = dataModel["productDescription"].stringValue
                        let productSpecification = dataModel["productSpecification"].stringValue
                        let associateId = dataModel["associateId"].stringValue
                        let inventory = dataModel["inventory"].stringValue
                        let productSold = dataModel["productSold"].stringValue
                        
                        let myImage = WebUrl.PRODUCT_IMAGE_URL+productImage
                        
                        self.dealerProductList.append(DealerProductsModel(productId: productId, productName: productName, price: price, productImage: myImage, productDescription: productDescription, productSpecification: productSpecification, associateId: associateId, inventory: inventory, productSold: productSold))
                    }
                    
                    self.myTablview.reloadData()
                    
                }
                }
                
            //Network Error
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
///////////*****************Function End to Partner Product List *****************/
    
    
/*****************Function Start to Get Dealer Products *****************///////////
    @objc func getDealerProduct(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        
        // Parameters
        let parameters: [String: Any] = ["token":token]
        
        //Alamofire Request
        Alamofire.request(WebUrl.PRODUCT_LIST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let myDealerList = JSON(i)
                    let productList = myDealerList["productList"].array
                    for dataModel in productList! {
                        let productId = dataModel["productId"].stringValue
                        let productName = dataModel["productName"].stringValue
                        let price = dataModel["price"].stringValue
                        let productImage = dataModel["productImage"].stringValue
                        let productDescription = dataModel["productDescription"].stringValue
                        let productSpecification = dataModel["productSpecification"].stringValue
                        let associateId = dataModel["associateId"].stringValue
                        let inventory = dataModel["inventory"].stringValue
                        let productSold = dataModel["productSold"].stringValue

                        let myImage = WebUrl.PRODUCT_IMAGE_URL+productImage
                        
                        self.dealerProductList.append(DealerProductsModel(productId: productId, productName: productName, price: price, productImage: myImage, productDescription: productDescription, productSpecification: productSpecification, associateId: associateId, inventory: inventory, productSold: productSold))
                    }
                   
                    self.myTablview.reloadData()
                    
                }
                }
                
            //Network Error
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
///////////*****************Function End to Dealer Product List *****************/
    
/*****************Function Start to Get Dealer Products *****************///////////
    @objc func getCoupons(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyaltyId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.COUPON_LIST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let myCouponList = JSON(i)
                    let couponList = myCouponList["couponList"].array
                    for dataModel in couponList! {
                        let productId = dataModel["productId"].stringValue
                        let couponDescription = dataModel["couponDescription"].stringValue
                        let expiryDate = dataModel["expiryDate"].stringValue
                        let couponSpecification = dataModel["couponSpecification"].stringValue
                        let autoId = dataModel["autoId"].stringValue
                        let inventory = dataModel["inventory"].stringValue
                        let couponImage = dataModel["couponImage"].stringValue
                        let couponStatus = dataModel["couponStatus"].stringValue
                        let couponCode = dataModel["couponCode"].stringValue
                        let couponName = dataModel["couponName"].stringValue
                        let couponPrice = dataModel["couponPrice"].stringValue
                        let couponId = dataModel["couponId"].stringValue
                        
                        self.CouponList.append(CouponModel(productId: productId, couponDescription: couponDescription, expiryDate: expiryDate, couponSpecification: couponSpecification, autoId: autoId, inventory: inventory, couponImage: couponImage, couponStatus: couponStatus, couponCode: couponCode, couponName: couponName, couponPrice: couponPrice, couponId: couponId))

                    }
                    
                    self.myTablview.reloadData()
                    
                }
            }
                
            //Network Error
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
///////////*****************Function End to Dealer Product List *****************/
    
    
    
/*****************Function Start to Get Dealer Products *****************///////////
    @objc func getVoucher(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyaltyId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.VOUCHER_LIST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let myVoucherList = JSON(i)
                    let voucherList = myVoucherList["voucherList"].array
                    for dataModel in voucherList! {
                        let updated_at = dataModel["updated_at"].stringValue
                        let voucherDescription = dataModel["voucherDescription"].stringValue
                        let associateName = dataModel["associateName"].stringValue
                        let voucherStatus = dataModel["voucherStatus"].stringValue
                        let tierId = dataModel["tierId"].stringValue
                        let updatedBy = dataModel["updatedBy"].stringValue
                        let updatedType = dataModel["updatedType"].stringValue
                        let id = dataModel["id"].stringValue
                        let voucherTypeId = dataModel["voucherTypeId"].stringValue
                        let created_at = dataModel["created_at"].stringValue
                        let associateId = dataModel["associateId"].stringValue
                        let voucherState = dataModel["voucherState"].stringValue
                        let voucherName = dataModel["voucherName"].stringValue

                        self.VoucherList.append(VoucherModel(updated_at: updated_at, voucherDescription: voucherDescription, associateName: associateName, voucherStatus: voucherStatus, tierId: tierId, updatedBy: updatedBy, updatedType: updatedType, id: id, voucherTypeId: voucherTypeId, created_at: created_at, associateId: associateId, voucherState: voucherState, voucherName: voucherName))
                    }
                    
                    self.myTablview.reloadData()
                    
                }
                }
                
            //Network Error
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
///////////*****************Function End to Dealer Product List *****************/
    
    
    /*****************Function Start to Get Dealer Products *****************///////////
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

