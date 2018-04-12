
import UIKit
import AlamofireImage
import Alamofire
import Toast_Swift
import SwiftyJSON


class UsedCarViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var selectedMenuItem : Int = 0
    var usedCarList : [UsedCar] = [UsedCar]()
    @IBOutlet var tableView2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsedCarList()
        self.sideMenuController()?.sideMenu?.delegate = MySideMenu()
    }
func getUsedCarList() {
    let token : String = UserDefaults.standard.string(forKey: "token")!
    
    // Parameters
    let parameters: [String: Any] = ["token":token]
    //Alamofire Request
    Alamofire.request(WebUrl.USED_CAR_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
        // print("NewCarJsonResponse: \(response.result)")
        
        /*****************Response Success *****************/
        switch response.result {
        case .success (let value):let json = JSON(value)
        print("JSON: \(json)")
        let status = json["status"].stringValue
        if (status == WebUrl.SUCCESS_CODE){
            let data = json["data"].array
            
            for i in data! {
                let usedcarList = i["usedcarList"].array // Read Json Object
                
                
                
                
                for dataModel in usedcarList! {      // Parse Json Array
                   let modelName = dataModel["modelName"].stringValue
                   let state = dataModel["state"].stringValue
                   let carId = dataModel["carId"].stringValue
                   let updated_at = dataModel["updated_at"].stringValue
                   let vehicleImages2 = dataModel["vehicleImages2"].stringValue
                   let variantName = dataModel["variantName"].stringValue
                   let kmsdriven = dataModel["kmsdriven"].stringValue
                   let brandName = dataModel["brandName"].stringValue
                   let color = dataModel["color"].stringValue
                   let carStatus = dataModel["carStatus"].stringValue
                   let status = dataModel["status"].stringValue
                   let updatedBy = dataModel["updatedBy"].stringValue
                   let updatedType = dataModel["updatedType"].stringValue
                   let id = dataModel["id"].stringValue
                   let vehicleImages1 = dataModel["vehicleImages1"].stringValue
                   let vehicleImages3 = dataModel["vehicleImages3"].stringValue
                   let created_at = dataModel["created_at"].stringValue
                   let modelYear = dataModel["modelYear"].stringValue
                   let owner = dataModel["owner"].stringValue
                   let price = dataModel["price"].stringValue
                   let comment = dataModel["comment"].stringValue
                   let dealerId = dataModel["dealerId"].stringValue
                   let registration = dataModel["registration"].stringValue
                    
                    
                    let myimage = WebUrl.USED_CAR_IMAGE_URL+vehicleImages1

                    
                    self.usedCarList.append(UsedCar(modelName: modelName, state: state, carId: carId, updated_at: updated_at, vehicleImages2: vehicleImages2, variantName: variantName, kmsdriven: kmsdriven, brandName: brandName, color: color, carStatus: carStatus, status: status, updatedBy: updatedBy, updatedType: updatedType, id: id, vehicleImages1: myimage, vehicleImages3: vehicleImages3, created_at: created_at, modelYear: modelYear, owner: owner, price: price, comment: comment, dealerId: dealerId, registration: registration))
                    
                    
                }
                
                self.tableView2.reloadData()
                
            }
            }
            
            /***************** Network Error *****************/
        case .failure (let error):
            self.view.makeToast("Network Error")
        }
    }
        
    }
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usedCarList.count
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell2 = Bundle.main.loadNibNamed("UsedCarCell", owner: self, options: nil)?.first as! UsedCarCell
    
         var kms : Int = Int((usedCarList[indexPath.row].kmsdriven as NSString).intValue)
            var totalKms : String = String(kms)
    
    
            let url = URL(string: usedCarList[indexPath.row].vehicleImages1)!
            cell2.UsecarImageView.af_setImage(withURL: url)
    
            cell2.CarNamelbl1.text = usedCarList[indexPath.row].modelName + "( " + usedCarList[indexPath.row].variantName + " )"
            cell2.Rslbl2.text = "₹ " + usedCarList[indexPath.row].price + " Lakh"
            cell2.Yearlbl3.text = usedCarList[indexPath.row].modelYear + "  |  " + totalKms + " kms"
            cell2.Placelbl5.text = usedCarList[indexPath.row].state
            return cell2
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 380.0;//Choose your custom row height
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "UsedCarDetailViewController") as! UsedCarDetailViewController
        SecVC.usedCarID = usedCarList[indexPath.row].id
        self.present(SecVC, animated: true, completion: nil)
       
   
    }
    
    @IBAction func HometoggleSideMenuBtn(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
        print("Home Menu Button")
    }
    

    
}

