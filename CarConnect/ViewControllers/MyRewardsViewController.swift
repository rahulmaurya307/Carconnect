
import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import AlamofireImage


class MyRewardsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var lblTotalPoint: UILabel!
    var pointHistoryList : [PointsModel] = [PointsModel]()
    var ReferalHistoryList : [ReferalModel] = [ReferalModel]()
    var trackReferalsList : [TrackReferals] = [TrackReferals]()
    var dealerOfferList : [DealerModel] = [DealerModel]()
    
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var View3: UIView!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var myTablview: UITableView!
    @IBOutlet weak var mySegmentControll: UISegmentedControl!
    @IBOutlet weak var lblDealer: UILabel!
    @IBOutlet weak var lblPartner: UILabel!
    
    @IBAction func btnHomeToggle(_ sender: Any) {
        toggleSideMenuView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        getTotalPoint()   // get Available point
        getPointHistory()  // get Point history
        
        View2.isHidden = true
        View3.isHidden = true
        
    }
    
    //Partner Button Click
    var ispartnerclick=false
    var isDealerClick=false
    var isReferralClick=false
    var isTrackClick=false
    
    @IBAction func btnpartner(_ sender: Any) {
        
        dealerOfferList.removeAll()
        getPartnerOffersList()
        ispartnerclick=true
        isDealerClick=false
        isReferralClick=false
        isTrackClick=false
        
        lblDealer.isHidden = true
        lblPartner.isHidden = false
        
        print("Button Partner CLick")
        myTablview.reloadData()
        
    }
    //Dealer Button Click
    
    @IBAction func btnDealer(_ sender: Any) {
        isDealerClick = true
        ispartnerclick=false
        isReferralClick=false
        isTrackClick=false
        
        dealerOfferList.removeAll()
        getDealerOffersList()
        lblDealer.isHidden = false
        lblPartner.isHidden = true
        
        print("Button Dealer CLick")
        myTablview.reloadData()
        
    }
    //Referal Button Click
    
    @IBAction func btnReferral(_ sender: Any) {
        isReferralClick = true
        isTrackClick=false
        ispartnerclick=false
        isDealerClick=false
        
        print("Button Referral CLick")
        ReferalHistoryList.removeAll()
        getReferalProgramList()
        myTablview.reloadData()
    }
    //Track Button Click
    
    @IBAction func btnTrack(_ sender: Any) {
        isTrackClick = true
        isReferralClick=false
        ispartnerclick=false
        isDealerClick=false
        
        print("Button Track CLick")
        trackReferalsList.removeAll()
        getTrackReferalList()
        myTablview.reloadData()
    }
    //Segment Click Start
    @IBAction func MySegmentAction(_ sender: Any) {
        switch (mySegmentControll.selectedSegmentIndex) {
        case 0:
            myTablview.reloadData()
            view1.isHidden = false
            View2.isHidden = true
            View3.isHidden = true
            
            ispartnerclick=false
            isDealerClick=false
            isReferralClick=false
            isTrackClick=false
            break
        case 1:
            ReferalHistoryList.removeAll()
            getReferalProgramList()
            myTablview.reloadData()
            
            view1.isHidden = true
            View2.isHidden = false
            View3.isHidden = true
            
            isReferralClick=true
            isTrackClick=false
            ispartnerclick=false
            isDealerClick=false
            
            break
            
        case 2:
            dealerOfferList.removeAll()
            getDealerOffersList()
            myTablview.reloadData()
            
            view1.isHidden = true
            View2.isHidden = true
            View3.isHidden = false
            
            lblDealer.isHidden = true
            lblPartner.isHidden = true
            
            isDealerClick=true
            ispartnerclick=false
            isReferralClick=false
            isTrackClick=false
            break
        default:
            break
        }
        
    }
    //Segment Click End
    
    
    
    
    
    
    /////////////////****************All Cell Array Size Start**************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        switch (mySegmentControll.selectedSegmentIndex) {
        case 0:
            
            returnValue = pointHistoryList.count
            
            break
        case 1:
            if isTrackClick
            {
                print("My Ref Track:")
                returnValue = trackReferalsList.count
                
            }else if isReferralClick
            {
                print("My Ref isReferralClick:")
                returnValue = ReferalHistoryList.count
            }
            
        case 2:
            
            if isDealerClick
            {
                returnValue = dealerOfferList.count
            }
                
            else if ispartnerclick
            {
                returnValue = dealerOfferList.count
            }
            
            // returnValue = arrayofcelldata4.count
            
        default:
            break
        }
        return returnValue
        
    }
    /****************All Cell Array Size End**************/////////////////
    
    
    
    /////////////////****************All Cell Click Enter  Start**************/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (mySegmentControll.selectedSegmentIndex)
        {
        case 0:
            break
        case 1:
            
            if isReferralClick
            {
                let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "ReferalViewController") as! ReferalViewController
                SecVC.referralTypeId = ReferalHistoryList[indexPath.row].id
                self.present(SecVC, animated: true, completion: nil)
                break
                
            }
            else if ispartnerclick {
                break
                
            }
            
        case 2:
            break
        default:
            break
        }
    }
    /****************All Cell Click Enter End**************/////////////////
    
    
    
    /////////////////****************All Cell Size Start**************/
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch (mySegmentControll.selectedSegmentIndex) {
        case 0:
            return 100.0
            
        case 1:
            
            if isTrackClick
            {
                return 200.0
                
            }
            
            if isReferralClick
            {
                return 75.0
                
            }
            return 75.0
            
        case 2:
            if ispartnerclick
            {
                return 280.0
                
            }
            
            if isDealerClick
            {
                return 280.0
                
            }
            
            return 280.0
            
        default:
            break
        }
        
        return 0
    }
    
    /****************All Cell  Size End**************/////////////////
    
    
    
    /////////////////****************All Cell Creating Start**************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = Bundle.main.loadNibNamed("Points", owner: self, options: nil)?.first as!
        Points
        switch (mySegmentControll.selectedSegmentIndex) {
        case 0:
            let cell2 = Bundle.main.loadNibNamed("Points", owner: self, options: nil)?.first as!
            Points
            
            /*Set Service Name*/
            var redeem : String = pointHistoryList[indexPath.row].redeemPoint
            var service : String = pointHistoryList[indexPath.row].serviceName
            var awards : String = pointHistoryList[indexPath.row].awardPoints
            let first = String(service.prefix(1)).capitalized
            let other = String(service.dropFirst())
            cell2.lblServiceName.text = first + other
            
            cell2.lblExpiryDate.isHidden = true
            
            /*Set Service Name*/
            let pendingStatus = pointHistoryList[indexPath.row].pendingStatus
            let isExpire = pointHistoryList[indexPath.row].isExpiry
            let expiryDate = pointHistoryList[indexPath.row].expiry
            
            
            
            
            /*Earn Point*/
            if(pendingStatus == true){
                cell2.lblEarnPoint.text = "Pending"
            }else if(awards == "0"){
                cell2.lblEarnPoint.isHidden = true
            }else if(pendingStatus == false){
                cell2.lblEarnPoint.text = "+"+pointHistoryList[indexPath.row].awardPoints+"(Earned)"
            }else if(isExpire == true){
                cell2.lblEarnPoint.isHidden = true
                
            }
            
            if(isExpire == false){
                cell2.expireImageView.isHidden = true
                cell2.expiresView.isHidden = true
            }
            
            /*Redeem Point*/
            if(pendingStatus == true){
                cell2.lblRedeemPoint.isHidden = true
            }else if(redeem == "0"){
                cell2.lblRedeemPoint.isHidden = true
            }else{
                cell2.lblRedeemPoint.text = "-"+pointHistoryList[indexPath.row].redeemPoint+"(Redeem)"
            }
            
            
            /*Expiry Date*/
            if(expiryDate == "null"){
                cell2.lblExpiryDate.isHidden = true
            }else{
                cell2.lblExpiryDate.text = "Expires On: " + pointHistoryList[indexPath.row].expiry
            }
            
            cell2.lblActivationDate.text = pointHistoryList[indexPath.row].invoiceDate
            
            return cell2
            
        case 1:
            if isTrackClick
            {
                
                let cell2 = Bundle.main.loadNibNamed("TrackReferalCell", owner: self, options: nil)?.first as! TrackReferalCell
                cell2.lbl1Track.text = trackReferalsList[indexPath.row].name!
                cell2.lbl2Track.text = trackReferalsList[indexPath.row].referralEmail!
                cell2.lbl3Track.text = trackReferalsList[indexPath.row].referralMobile!
                cell2.lbl4Track.text = trackReferalsList[indexPath.row].referralName!
                cell2.lbl5Track.text = trackReferalsList[indexPath.row].referralStatus!
                return cell2
                
                
            }
            
            if isReferralClick
            {
                do{
                    let cell2 = Bundle.main.loadNibNamed("Refer", owner: self, options: nil)?.first as! Refer
                    cell2.lblRefer.text = ReferalHistoryList[indexPath.row].name
                    cell2.lblRefer2.text = ReferalHistoryList[indexPath.row].amount
                    return cell2
                }
                catch {
                    
                    print("Catch Block Error")
                }
            }
            
        case 2:
            if isDealerClick
            {
                let cell2 = Bundle.main.loadNibNamed("DealerCell", owner: self, options: nil)?.first as! DealerCell
                
                let url = URL(string: dealerOfferList[indexPath.row].offerImage)!
                cell2.imageDealerCell.af_setImage(withURL: url)
                
                cell2.lbl1DealerCell.text = dealerOfferList[indexPath.row].offerName
                cell2.lbl2DealerCell.text = dealerOfferList[indexPath.row].offerDescription
                return cell2
            }
            
            if ispartnerclick
            {
                let cell2 = Bundle.main.loadNibNamed("DealerCell", owner: self, options: nil)?.first as! DealerCell
                
                let url = URL(string: dealerOfferList[indexPath.row].offerImage)!
                cell2.imageDealerCell.af_setImage(withURL: url)
                
                cell2.lbl1DealerCell.text = dealerOfferList[indexPath.row].offerName
                cell2.lbl2DealerCell.text = dealerOfferList[indexPath.row].offerDescription
                return cell2
            }
            
            
            
        default:
            break
        }
        return cell2
    }
    /****************All Cell Creating End**************/////////////////
    
    
    
    
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
                    self.lblTotalPoint.text = "Your Available Point : \(balancePoint)"
                }
                }
            //Network Error
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
    /*****************Function End to Get Total Points *****************///////////
    
    
    
    
    ///////////*****************Function Start to Get Points History *****************/
    func getPointHistory(){
        var isExpire : Bool!
        var pendingStatus : Bool!
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyaltyId]
        
        
        //Alamofire Request
        Alamofire.request(WebUrl.POINT_SUMMARY+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                for i in data! {
                    let datalist = i["orderList"].array
                    for dataModel in datalist! {
                        let serviceName = dataModel["serviceName"].stringValue
                        let awardPoints = dataModel["awardPoints"].stringValue
                        let redeemPoint = dataModel["redeemPoint"].stringValue
                        let txnCreatedAt = dataModel["txnCreatedAt"].stringValue
                        let modelName = dataModel["modelName"].stringValue
                        let invoiceDate = dataModel["invoiceDate"].stringValue
                        let expiry = dataModel["expiry"].stringValue
                        let activation = dataModel["activation"].stringValue
                        
                        /***** Get Todays Date*****/
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd-MM-yyyy"
                        let myString = formatter.string(from: Date())
                        let yourDate = formatter.date(from: myString)
                        //let currentDate = formatter.date(from: yourDate!)
                        
                        let expiryDate = formatter.date(from: expiry)
                        let activationDate = formatter.date(from: activation)
                        
                        if(serviceName == "Expire"){
                            isExpire = true
                        }
                        if(awardPoints != "0" || redeemPoint != "0"){
                            
                            if(expiry != ""){
                                if(activation == ""){
                                    isExpire = true
                                }
                                if yourDate?.compare(expiryDate!) == .orderedDescending {
                                    isExpire = true
                                }else{
                                    isExpire = false
                                }
                            }
                            
                            if(activation != ""){
                                print("Current Date:\(yourDate)")
                                
                                if yourDate?.compare(activationDate!) == .orderedSame {
                                    
                                    pendingStatus = false
                                }
                                else if yourDate?.compare(activationDate!) == .orderedDescending {
                                    pendingStatus = false
                                    print("Current Date:\("Small")")
                                }else{
                                    pendingStatus = true
                                    print("Current Date:\("Greater")")
                                }
                                
                            }
                            
                            //
                            
                            self.pointHistoryList.append(PointsModel(serviceName: serviceName, awardPoints: awardPoints, redeemPoint: redeemPoint, txnCreatedAt: txnCreatedAt, invoiceDate: invoiceDate, expiry: expiry, activation: activation, pendingStatus: pendingStatus, isExpiry: isExpire))
                        }
                        
                        
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
    
    ///////////*****************Function End to Get Points History *****************/
    
    
    
    
    /*****************Function Start to Referal List *****************///////////
    
    func getReferalProgramList(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["token":token]
        
        //Alamofire Request
        Alamofire.request(WebUrl.REFERRAL_LIST_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let myRefList = JSON(i)
                    let refdescList = myRefList["refdescList"].array
                    
                    for dataModel in refdescList! {
                        let id = dataModel["id"].stringValue
                        let name = dataModel["name"].stringValue
                        let amount = dataModel["amount"].stringValue
                        
                        self.ReferalHistoryList.append(ReferalModel(id: id, name: name, amount: amount))
                        
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
    ///////////*****************Function End to Referal List *****************/
    
    
    
    /*****************Function Start to Get Track Referal *****************///////////
    
    func getTrackReferalList(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyaltyId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.REFERRAL_HISTORY_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("Track Referal JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let myTrackRefList = JSON(i)
                    let referralHistory = myTrackRefList["referralHistory"].array
                    
                    for dataModel in referralHistory! {
                        let referralId = dataModel["referralId"].stringValue
                        let name = dataModel["name"].stringValue
                        let referralStatus = dataModel["referralStatus"].stringValue
                        let referralEmail = dataModel["referralEmail"].stringValue
                        let referralName = dataModel["referralName"].stringValue
                        let referralMobile = dataModel["referralMobile"].stringValue
                        
                        self.trackReferalsList.append(TrackReferals(referralId: referralId, name: name, referralStatus: referralStatus, referralEmail: referralEmail, referralName: referralName, referralMobile: referralMobile))
                        
                        
                    }
                    
                }
                
                
                self.myTablview.reloadData()
                }
                
            //Network Error
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
    
    ///////////*****************Function End to Get Track Referal *****************/
    
    
    /*****************Function Start to Get Dealer Offers List *****************///////////
    
    func getDealerOffersList(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["token":token]
        
        //Alamofire Request
        Alamofire.request(WebUrl.DEALER_OFFERS_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("Track Referal JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let myTrackRefList = JSON(i)
                    let offerList = myTrackRefList["offerList"].array
                    
                    for dataModel in offerList! {
                        let offerDescription = dataModel["offerDescription"].stringValue
                        let offerImage = dataModel["offerImage"].stringValue
                        let offerName = dataModel["offerName"].stringValue
                        
                        let myimage = WebUrl.OFFERS_IMAGE_URL+offerImage
                        
                        self.dealerOfferList.append(DealerModel(offerDescription: offerDescription, offerImage: myimage, offerName: offerName))
                        
                    }
                    
                }
                self.myTablview.reloadData()
                }
                
            //Network Error
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
    
    ///////////*****************Function End to Get Dealer Offers List*****************/
    
    
    /*****************Function Start to Get Partner Offers List *****************///////////
    
    func getPartnerOffersList(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["token":token]
        
        //Alamofire Request
        Alamofire.request(WebUrl.PARTNER_OFFERS_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("Track Referal JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let myPartnerList = JSON(i)
                    let associatePartnerOfferList = myPartnerList["associatePartnerOfferList"].array
                    
                    for dataModel in associatePartnerOfferList! {
                        let offerDescription = dataModel["offerDescription"].stringValue
                        let offerImage = dataModel["offerImage"].stringValue
                        let offerName = dataModel["offerName"].stringValue
                        
                        let myimage = WebUrl.OFFERS_IMAGE_URL+offerImage
                        
                        self.dealerOfferList.append(DealerModel(offerDescription: offerDescription, offerImage: myimage, offerName: offerName))
                        
                    }
                    
                }
                self.myTablview.reloadData()
                }
                
            //Network Error
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
    
    ///////////*****************Function End to Get Partner Offers List*****************/
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

