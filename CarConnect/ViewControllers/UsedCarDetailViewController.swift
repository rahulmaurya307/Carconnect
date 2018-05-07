
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift

class UsedCarDetailViewController: UIViewController {
    var intrestStatus : String!
    var mobileNumber : String!
    
/*********IDs********/
    
    @IBOutlet var btnInterestSent: UIButton!
    @IBOutlet var imgcar: UIImageView!
    @IBOutlet var lblModelName: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblYear: UILabel!
    @IBOutlet var lblFuel: UILabel!
    @IBOutlet var lblGearType: UILabel!
    @IBOutlet var lblLocation: UILabel!
    @IBOutlet var lblKms: UILabel!
    @IBOutlet var lblOwnerComment: UILabel!
    @IBOutlet var lblRegNo: UILabel!
    @IBOutlet var lblCarColor: UILabel!
    @IBOutlet var lblOwner: UILabel!
    /*********IDs********/
    
    var usedCarID : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        getUSedCarDetail()

    }
  

    @IBAction func BackBtn(_ sender: Any) {
        self.dismiss(animated:true, completion: nil)
    }
    
    @IBAction func btnInterestSent(_ sender: Any) {
        if (intrestStatus == "1") {
            btnInterestSent.isEnabled = false
        }else{
            btnInterestSent.isEnabled = true
            showInterest()
            
        }
    }
    
    
    @IBAction func btnCallDriver(_ sender: Any) {
        
        if let url = URL(string: "tel://"+mobileNumber), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
        print(mobileNumber)
        
//        if let url = URL(string: "tel://\(mobileNumber)"), UIApplication.shared.canOpenURL(url) {
//            if #available(iOS 10, *) {
//                UIApplication.shared.open(url)
//            } else {
//                UIApplication.shared.openURL(url)
//            }
//        }
       
    }
    
@objc func getUSedCarDetail(){
    self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["sellId" : usedCarID!]
    
        //Alamofire Request
        Alamofire.request(WebUrl.USED_CAR_DETAIL_LIST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            // print("NewCarJsonResponse: \(response.result)")
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let usedcarList = i["carList"].array // Read Json Object
                    
                    for dataModel in usedcarList! {      // Parse Json Array
                        let state = dataModel["state"].stringValue
                        let brandName = dataModel["brandName"].stringValue
                        let kmsdriven = dataModel["kmsdriven"].intValue
                        let vehicleImages1 = dataModel["vehicleImages1"].stringValue
                        let vehicleImages2 = dataModel["vehicleImages2"].stringValue
                        let vehicleImages3 = dataModel["vehicleImages3"].stringValue
                        let color = dataModel["color"].stringValue
                        let id = dataModel["id"].stringValue
                        let owner = dataModel["owner"].stringValue
                        let comment = dataModel["comment"].stringValue
                        let registration = dataModel["registration"].stringValue
                        let carId = dataModel["carId"].stringValue
                        let fuelType = dataModel["fuelType"].stringValue
                        self.mobileNumber = dataModel["dealerMobile"].stringValue
                        let variantName = dataModel["variantName"].stringValue
                        let carStatus = dataModel["carStatus"].stringValue
                        let price = dataModel["price"].stringValue
                        let status = dataModel["status"].stringValue
                        self.intrestStatus = dataModel["interestedCarstatus"].stringValue
                        let modelYear = dataModel["modelYear"].stringValue
                        let dealerId = dataModel["dealerId"].stringValue
                        let modelName = dataModel["modelName"].stringValue
                        
                    
                        self.lblModelName.text = modelName + "( " + variantName + ")"
                        //self.lblPrice.text = "₹ " + price + " Lakh"
                        self.lblYear.text = modelYear
                        self.lblFuel.text = fuelType
                        self.lblLocation.text = state
                        self.lblKms.text = String(describing: kmsdriven) + "kms"
                        self.lblOwnerComment.text = comment
                        self.lblRegNo.text = registration
                        self.lblOwner.text = owner
                        self.lblCarColor.text = color
                        
                        let myimage1 = WebUrl.USED_CAR_IMAGE_URL+vehicleImages1
                        let myimage2 = WebUrl.USED_CAR_IMAGE_URL+vehicleImages2
                        let myimage3 = WebUrl.USED_CAR_IMAGE_URL+vehicleImages3
                        
                        let url = URL(string: myimage1)!
                        self.imgcar.af_setImage(withURL: url)
                        
                        
                        if(Int(price)! < 9999999){
                            self.lblPrice.text = "₹ " + String(Double(price)! / 100000 ) + " Lakh"
                        }else  if(Int(price)! > 9999999){
                            self.lblPrice.text = "₹ " + String(Double(price)! / 1000000 ) + " Crore"
                        }
                        
                        if (self.intrestStatus == "1") {
                            
                        self.btnInterestSent.backgroundColor = UIColor.red
                            self.btnInterestSent.setTitle("INTEREST SENT", for:.normal)
                            self.btnInterestSent.isEnabled = false
                            
                            
                        }
              
                        
                        
                    }
                }
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
        
        
    }
    
    @objc func showInterest(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let userId : String = UserDefaults.standard.string(forKey: "userId")!
        
        
        // Parameters
        let parameters: [String: Any] = ["usedcarId" : usedCarID!, "userId": userId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.SHOW_INTREST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            // print("NewCarJsonResponse: \(response.result)")
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                self.view.makeToast("Interest Sent")
                self.btnInterestSent.backgroundColor = UIColor.red
                self.btnInterestSent.setTitle("Interest Sent", for:.normal)
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
                self.intrestStatus = "1"
            }
        }
        
        
    }
    
    

}
