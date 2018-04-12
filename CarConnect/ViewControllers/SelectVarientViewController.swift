

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift

struct CellDataSelectVarient {
    
    let cell2 : Int!
    let text1 : String!
    
    
}


class SelectVarientViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var noItemView: UIView!
    var selectedMenuItem : Int = 0
    var arrayofcelldata2 = [CellDataSelectVarient]()
    var brandId : String!
    var modelId : String!
    var brandName : String!
    var modelName : String!
    var flag : String!
    
    var selectCarList : [SelectCar] = [SelectCar]()
    
    @IBOutlet var tableView2: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectVarient()
        self.sideMenuController()?.sideMenu?.delegate = MySideMenu()
        arrayofcelldata2 =  [CellDataSelectVarient(cell2 : 1 , text1 : "Car Model 1"),
                             CellDataSelectVarient(cell2 : 1 , text1 : "Car Model 2"),
                            CellDataSelectVarient(cell2 : 1 , text1 : "Car Model 3")]
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectCarList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell2 = Bundle.main.loadNibNamed("SelectBrandTableViewCell", owner: self, options: nil)?.first as! SelectBrandTableViewCell
    
            cell2.LblBrandName.text = selectCarList[indexPath.row].brandName
            
            
            return cell2
            
      
            
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50;//Choose your custom row height
    }
    
// method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(flag == "car1"){
            UserDefaults.standard.set(true, forKey: "car1")
            UserDefaults.standard.set(brandId, forKey: "brandId1")
            UserDefaults.standard.set(modelId, forKey: "modelId1")
            UserDefaults.standard.set(selectCarList[indexPath.row].id, forKey: "varientId1")
            UserDefaults.standard.set(brandName, forKey: "brandName1")
            UserDefaults.standard.set(modelName, forKey: "modelName1")
            UserDefaults.standard.set(selectCarList[indexPath.row].brandName, forKey: "varientName1")
            UserDefaults.standard.set(selectCarList[indexPath.row].brandImage, forKey: "varientImage1")
        }else if(flag == "car2"){
            print(flag)
            UserDefaults.standard.set(true, forKey: "car2")
            UserDefaults.standard.set(brandId, forKey: "brandId2")
            UserDefaults.standard.set(modelId, forKey: "modelId2")
            UserDefaults.standard.set(selectCarList[indexPath.row].id, forKey: "varientId2")
            UserDefaults.standard.set(brandName, forKey: "brandName2")
            UserDefaults.standard.set(modelName, forKey: "modelName2")
            UserDefaults.standard.set(selectCarList[indexPath.row].brandName, forKey: "varientName2")
            UserDefaults.standard.set(selectCarList[indexPath.row].brandImage, forKey: "varientImage2")
        }
        
        
        let comVC = self.storyboard?.instantiateViewController(withIdentifier: "CompareViewController") as! CompareViewController
        comVC.brandId = brandId
        comVC.modelId = modelId
        comVC.brandName = brandName
        comVC.modelName = modelName
        comVC.flag = flag
        comVC.varientImage = selectCarList[indexPath.row].brandImage
        comVC.varientName = selectCarList[indexPath.row].brandName
        AppDelegate.getDelegate().resetView2()
        
    }

    @IBAction func backBtn (_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
/**************************** Select Car 2 ******************************/
    func selectVarient(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        // Parameters
        let parameters: [String: Any] = ["brandId":brandId, "modelId":modelId]
        
       
        
        //Alamofire Request
        Alamofire.request(WebUrl.VARIANT_LIST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            /*****************Response Success *****************/
            
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                for i in data! {
                    let varientList = i["filterlist"].array! // Read Json Object
                    for j in varientList{
                        var variantId = j["variantId"].stringValue
                        var variantName = j["variantName"].stringValue
                        var image = j["modelImage"].stringValue
                        
                        let modelImage = WebUrl.NEW_CARS + image
                        
                        self.selectCarList.append(SelectCar(id: variantId, brandImage: modelImage, brandName: variantName))
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




