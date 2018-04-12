
import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
import Toast_Swift


@objc class EStoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   @IBOutlet fileprivate var rightBarButton: BadgedBarButtonItem!
    fileprivate var leftCount = 0
    fileprivate var rightCount = 0
    
    @IBOutlet var btnOrder: UIButton!
    @IBOutlet var btnPartner: UIButton!
    @IBOutlet var btnDealer: UIButton!
    @IBOutlet var myTableConstraint: NSLayoutConstraint!
    @IBOutlet var noItemsView : UIView!
    var sender: BadgedBarButtonItem!
    
    @IBOutlet weak var View3: UIView!
    @IBOutlet weak var myTablview: UITableView!
    @IBOutlet weak var mySegmentControll: UISegmentedControl!
     var dealerProductList : [DealerProductsModel] = [DealerProductsModel]()
    var orderSummaryList : [OrderSummaryModel] = [OrderSummaryModel]()
    var CouponList : [CouponModel] = [CouponModel]()
    var VoucherList : [VoucherModel] = [VoucherModel]()
    var productList : [JSON]?
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
         btnDealer.backgroundColor = UIColor(red: 82/255, green: 98/255, blue: 133/255, alpha: 1)
        var order = UserDefaults.standard.bool(forKey: "order")
        print("Order : \(order)")
        if (order == true){
            btnPartner.backgroundColor = UIColor.clear
            btnDealer.backgroundColor = UIColor.clear
            btnOrder.backgroundColor = UIColor(red: 82/255, green: 98/255, blue: 133/255, alpha: 1)
             print("Order : \(order)")
            orderSummaryList.removeAll()
            getOrederSummary()
            isDealerClick = false
            ispartnerclick=false
            isOrderClick=true
            myTablview.reloadData()
        }else{
            
            myTablview.backgroundView = noItemsView
            noItemsView.isHidden = true
            
            self.isDealerClick = true
            getDealerProduct()
            View3.isHidden = false
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
         getMyCartListCount()
    }
    

    override func viewWillDisappear(_ animated: Bool) {
       var order = UserDefaults.standard.bool(forKey: "order")
        if (order.description.isEmpty){
            print("Empty")
        }else{
            UserDefaults.standard.removeObject(forKey: "order")
        }
        
    }
    
    func noData(){
        if myTablview.visibleCells.isEmpty{
            noItemsView.isHidden = false
        }else {
            noItemsView.isHidden = true
        }
    }
    
    var ispartnerclick=false
    @IBAction func btnpartner(_ sender: Any) {
        btnPartner.backgroundColor = UIColor(red: 82/255, green: 98/255, blue: 133/255, alpha: 1)
        btnDealer.backgroundColor = UIColor.clear
        btnOrder.backgroundColor = UIColor.clear
        dealerProductList.removeAll()
        getPartnerProduct()
        ispartnerclick=true
        isDealerClick=false
        isOrderClick=false
     
        myTablview.reloadData()
        
    }
    
    var isDealerClick=false
    @IBAction func btnDealer(_ sender: Any) {
        
        btnPartner.backgroundColor = UIColor.clear
        btnDealer.backgroundColor = UIColor(red: 82/255, green: 98/255, blue: 133/255, alpha: 1)
        btnOrder.backgroundColor = UIColor.clear
   
        dealerProductList.removeAll()
        getDealerProduct()
        isDealerClick = true
        ispartnerclick=false
        isOrderClick=false
  
        myTablview.reloadData()
        
    }
    var isOrderClick=false
    @IBAction func btnOrder(_ sender: Any) {
        
        btnPartner.backgroundColor = UIColor.clear
        btnDealer.backgroundColor = UIColor.clear
        btnOrder.backgroundColor = UIColor(red: 82/255, green: 98/255, blue: 133/255, alpha: 1)
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
            CouponCell.lblExpirydate.text = "Expiry Date : " + CouponList[indexPath.row].expiryDate
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
            return 190.0
            
        case 2:
           
            return 160
            
        default:
            break
        }
        
        return 0
    }
    
/*****************Function Start to Get Order Summary *****************///////////
     @objc func getOrederSummary(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["token":token,"loyaltyId":loyaltyId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.TRANSCATION_HISTORY+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
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
                    self.noData()
                    
                }
                }
                
            //Network Error
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }
///////////*****************Function End to get Order Summary *****************/
    
    
/*****************Function Start to Get Partner Products *****************///////////
    @objc func getPartnerProduct(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["token":token]
        
        //Alamofire Request
        Alamofire.request(WebUrl.PARTNER_PRODUCT_LIST+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
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
                    self.noData()
                    
                }
                }
                
            //Network Error
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }
///////////*****************Function End to Partner Product List *****************/
    
    
/*****************Function Start to Get Dealer Products *****************///////////
    @objc func getDealerProduct(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        
        // Parameters
        let parameters: [String: Any] = ["token":token]
        
        //Alamofire Request
        Alamofire.request(WebUrl.PRODUCT_LIST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
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
                    self.noData()
                    
                }
                }
                
            //Network Error
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }
///////////*****************Function End to Dealer Product List *****************/
    
/*****************Function Start to Get Dealer Products *****************///////////
    @objc func getCoupons(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyaltyId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.COUPON_LIST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
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
                    self.noData()
                    
                }
            }
                
            //Network Error
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }
///////////*****************Function End to Dealer Product List *****************/
    
    
    
/*****************Function Start to Get Dealer Products *****************///////////
    @objc func getVoucher(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyaltyId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.VOUCHER_LIST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
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
                    self.noData()
                    
                }
                }
                
            //Network Error
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }
    
    func getMyCartListCount()
    {
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyaltyId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.CART_LIST_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("Track Referal JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                UserDefaults.standard.set(String(describing: json), forKey: "cartData") //setObject
                let data = json["data"].array
                for i in data! {
                    let myTrackRefList = JSON(i)
                    self.productList = myTrackRefList["productList"].array
                }
                print("productList : \(self.productList?.count)")
                self.rightBarButton.badgeValue = (self.productList?.count)!
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

