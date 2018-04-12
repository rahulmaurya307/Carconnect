

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
import Toast_Swift

struct CellDataSelectModel {
    
    let cell2 : Int!
    let text1 : String!
     
}


class SelectModelViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet var noItemView: UIView!
    
    var selectedMenuItem : Int = 0
    var arrayofcelldata2 = [CellDataSelectModel]()
    var brandId : String!
    var brandName : String!
    var flag : String!
    var selectModelList : [SelectMOdel] = [SelectMOdel]()
    
    
    @IBOutlet var tableView2: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectcar2()
        self.sideMenuController()?.sideMenu?.delegate = MySideMenu()
        arrayofcelldata2 =  [CellDataSelectModel(cell2 : 1 , text1 : "Car Model 1"),
                             CellDataSelectModel(cell2 : 1 , text1 : "Car Model 2")]
   
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = Bundle.main.loadNibNamed("SelectBrandTableViewCell", owner: self, options: nil)?.first as!
        SelectBrandTableViewCell
        cell2.LblBrandName.text = selectModelList[indexPath.row].modelName
        return cell2
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectVarientViewController") as! SelectVarientViewController
        SecVC.brandId = brandId
        SecVC.modelId = selectModelList[indexPath.row].id
        SecVC.brandName = brandName
        SecVC.modelName = selectModelList[indexPath.row].modelName
        SecVC.flag = flag
        self.present(SecVC, animated: true, completion: nil)
    }
    
    @IBAction func backBtn (_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
/**************************** Select Car 2 ******************************/
    func selectcar2(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        // Parameters
        let parameters: [String: Any] = ["token":token, "brandId":brandId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.MODEL_LIST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            /*****************Response Success *****************/
            
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                for i in data! {
                    let modelList = i["modelList"].array! // Read Json Object
                    for j in modelList{
                       var id = j["id"].stringValue
                       var modelName = j["modelName"].stringValue
                        self.selectModelList.append(SelectMOdel(id: id, modelName: modelName))
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



