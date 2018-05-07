
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift


class BrandSpecificationViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    var varientId : String!
    var carId : String!
    var ModelName : String!
    var mobileNumber : String!
    var dealerMobile : String!
    
    var price : String!
    var imageUrl : String!
    
    
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var imgvwCar: UIImageView!
    @IBOutlet var lblModelName: UILabel!
    var selectedMenuItem : Int = 0
    @IBOutlet var tableView2: UITableView!
    var caroverViewList : [carSpecificModel] = [carSpecificModel]()
    var carSpecList : [carSpecificModel] = [carSpecificModel]()
    var carFeatureList : [carSpecificModel] = [carSpecificModel]()
  
    @IBOutlet var mySegControll: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        varientSpecification()
        print("Model Name: \(ModelName)")
        print("Price: \(price)")
        print("Images: \(imageUrl)")
        
        lblPrice.text = price
        lblModelName.text = ModelName
     
        let myimage3 = WebUrl.NEW_CARS + imageUrl!
        var myImageurl = URL(string: myimage3)
        imgvwCar.af_setImage(withURL: myImageurl!)
    
    }
    
   
    @IBAction func BackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnCall(_ sender: Any) {
        print(dealerMobile)
        if let url = URL(string: "tel://"+dealerMobile), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
    @IBAction func btnBookDrive(_ sender: Any) {
        
        let  BookVC = self.storyboard?.instantiateViewController(withIdentifier: "BookTestDriveViewController") as! BookTestDriveViewController
        BookVC.carId = carId
        self.present(BookVC, animated: true, completion: nil)
    }
    
    @IBAction func mySegControll(_ sender: Any) {
        
        switch (mySegControll.selectedSegmentIndex) {
        case 0:
            tableView2.reloadData()
            break
        case 1:
            tableView2.reloadData()
            break
        case 2:
            tableView2.reloadData()
            break
        default:
            break
        }
        
    }
    
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (mySegControll.selectedSegmentIndex) {
        case 0:
            return caroverViewList.count
        case 1:
            return carSpecList.count
        case 2:
            return carFeatureList.count
        default:
            break
        }
    return caroverViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (mySegControll.selectedSegmentIndex) {
        case 0:
            let cell2 = Bundle.main.loadNibNamed("SpecificationTableViewCell", owner: self, options: nil)?.first as!
            SpecificationTableViewCell
            
            var value : String! = caroverViewList[indexPath.row].specificationName
            
            cell2.SpecName.text = caroverViewList[indexPath.row].specificationName
            cell2.SpecVal.text = caroverViewList[indexPath.row].specificationvalue
            return cell2
           
        case 1:
            let cell2 = Bundle.main.loadNibNamed("SpecificationTableViewCell", owner: self, options: nil)?.first as!
            SpecificationTableViewCell
            var value : String = carSpecList[indexPath.row].specificationvalue
            
            cell2.SpecName.text = carSpecList[indexPath.row].specificationName
            cell2.SpecVal.text = carSpecList[indexPath.row].specificationvalue
            
            if(value == "subGroup"){
                cell2.backgroundColor = UIColor.lightGray
                cell2.SpecVal.font = UIFont.boldSystemFont(ofSize: 16.0)
                cell2.SpecVal.isHidden = true
            }else{
                cell2.backgroundColor = UIColor.white
                cell2.SpecVal.isHidden = false
            }
            
            return cell2
        
        case 2:
            let cell2 = Bundle.main.loadNibNamed("SpecificationTableViewCell", owner: self, options: nil)?.first as!
            SpecificationTableViewCell
            cell2.SpecName.text = carFeatureList[indexPath.row].specificationName
            let value : String = carFeatureList[indexPath.row].specificationvalue
            cell2.SpecVal.text = carFeatureList[indexPath.row].specificationvalue
            
            
            if(value == "hello"){
                 print(value)
                cell2.backgroundColor = UIColor.lightGray
                cell2.SpecVal.isHidden = true
                cell2.SpecVal.font = UIFont.boldSystemFont(ofSize: 16.0)
            }else{
                cell2.backgroundColor = UIColor.white
                cell2.SpecVal.isHidden = false
            }
            
            return cell2
        
        default:
            break
        }
            let cell2 = Bundle.main.loadNibNamed("SpecificationTableViewCell", owner: self, options: nil)?.first as!
            SpecificationTableViewCell
            cell2.SpecName.text = caroverViewList[indexPath.row].specificationName
            cell2.SpecVal.text = caroverViewList[indexPath.row].specificationvalue
            return cell2
}
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40;//Choose your custom row height
    }
    
    @objc func varientSpecification(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        // Parameters
        let parameters: [String: Any] = ["varientId":varientId!]
                print("CAR ID :\(varientId)")
        
      
        //Alamofire Request
        Alamofire.request(WebUrl.VARIANT_SPECIFICATION_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            /*****************Response Success *****************/
            
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                for i in data! {
                    let specificationList = i["specificationList"].array! // Read Json Object
                    
                    
                    for var i in (0...specificationList.count)
                    {
                        // Overview Array
                        let overViewData = specificationList[0] as JSON
                        let overViewArray = overViewData["subGroup"].array
                        for i in overViewArray! {
                            var specName = i["specificationName"].stringValue
                            var value = i["value"].stringValue
                        
                           self.caroverViewList.append(carSpecificModel(specificationName: specName, specificationvalue: value))
                        }
                        
                        //Specifications Data
                        let specificationData = specificationList[1] as JSON
                        let specificationArray = specificationData["subGroup"].array!
                        
                        for i in specificationArray {
                            var specName = i["specificationName"].stringValue
                            var value = i["value"].stringValue
                            
                            self.carSpecList.append(carSpecificModel(specificationName: specName, specificationvalue: "subGroup"))
                            
                             var subGroupArray = i["subGroup"].array!
                            for i in subGroupArray {
                                var specName = i["specificationName"].stringValue
                                var value = i["value"].stringValue
                                
                                self.carSpecList.append(carSpecificModel(specificationName: specName, specificationvalue: value))
                            }
                        }
                        
                        //Feature Data
                        let featureData = specificationList[2] as JSON
                        let featureArray = featureData["subGroup"].array!
                        
                        for i in featureArray {
                            var specName = i["specificationName"].stringValue
                            var value = i["value"].stringValue
                            
                            self.carFeatureList.append(carSpecificModel(specificationName: specName, specificationvalue: "hello"))
                            
                            var subGroupArray = i["subGroup"].array!
                            for i in subGroupArray {
                                var specName = i["specificationName"].stringValue
                                var value = i["value"].stringValue
                                
                                self.carFeatureList.append(carSpecificModel(specificationName: specName, specificationvalue: value))
                            }
                            
                            
                        }
                    }
                   
                }
                self.tableView2.reloadData()
                
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
        
        
        
        
    }
    

}
    
    



