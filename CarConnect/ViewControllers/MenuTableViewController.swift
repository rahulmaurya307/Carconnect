//
//  MenuTableViewController.swift
//  SideMenuExample
//
//  Created by Saurabh Sharma on 10/5/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import Toast_Swift
import SwiftyJSON

struct CellData {
    
    var cell : Int!
    var text : String!
    var image : UIImage!
   
}
class MenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var lblCardNo: UILabel!
    
    @IBOutlet var lblName: UILabel!
    var selectedMenuItem : Int = 0
    var arrayofcelldata = [CellData]()
    
    // Data model: These strings will be the data for the table view cells
   // let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    //let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            getProfile()
            arrayofcelldata = [CellData(cell : 1, text : "Home", image:#imageLiteral(resourceName: "ic_home")),
                           CellData(cell : 1, text : "My Rewards", image :#imageLiteral(resourceName: "ic_used_car_green")),
                           CellData(cell : 1, text : "E-Store", image :#imageLiteral(resourceName: "ic_used_car_green")),
                           CellData(cell : 1, text : "My Cars", image :#imageLiteral(resourceName: "ic_car_green") ),
                           CellData(cell : 1, text : "New Cars", image :#imageLiteral(resourceName: "ic_car_green") ),
                           CellData(cell : 1, text : "Used Cars", image :#imageLiteral(resourceName: "ic_used_car_green") ),
                           CellData(cell : 1, text : "Compare Cars", image :#imageLiteral(resourceName: "ic_compare_green") ),
                           CellData(cell : 1, text : "News", image :#imageLiteral(resourceName: "ic_news_green")  ),
                           CellData(cell : 1, text : "Loan Assistance", image :#imageLiteral(resourceName: "ic_car_loan_green") ),
                           CellData(cell : 1, text : "Road Side Assistance", image :#imageLiteral(resourceName: "ic_service") ),
                           CellData(cell : 1, text : "Brand HelpLines", image : #imageLiteral(resourceName: "ic_helpline")  ),
                           CellData(cell : 1, text : "Logout", image :#imageLiteral(resourceName: "ic_expert_review_green") )]
                lblName.text = UserDefaults.standard.string(forKey: "name")!
        
        
    }
    
    func getProfile(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let userId : String = UserDefaults.standard.string(forKey: "userId")!
        
        // Parameters
        let parameters: [String: Any] = ["userId":userId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.GET_PROFILE+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
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
                    //let newCarList = i["newcarList"] as JSON // Read Json Object
                    let userInfo = i["userInfo"].array
                    
                    for dataModel in userInfo! {      // Parse Json Array
                        let cardNo = dataModel["cardNo"].stringValue
                        self.lblCardNo.text = cardNo
                        print("cardNo : \(cardNo)")
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
  
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayofcelldata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = Bundle.main.loadNibNamed("MenuTableViewCell", owner: self, options: nil)?.first as! MenuTableViewCell
            cell.MainImageView.image = arrayofcelldata[indexPath.row].image
            cell.MainLabel.text = arrayofcelldata[indexPath.row].text
        cell.MainImageView.image = cell.MainImageView.image!.withRenderingMode(.alwaysTemplate)
        cell.MainImageView.tintColor = UIColor.white
            return cell
  
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var destViewController : UIViewController
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
            switch (indexPath.row) {
            case 0:
            if (indexPath.row) == 0{
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
            sideMenuController()?.setContentViewController(destViewController)
                }
                break
                
            case 1:
                if (indexPath.row) == 1{
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "MyRewardsViewController") as! MyRewardsViewController
                        sideMenuController()?.setContentViewController(destViewController)
                   
                }
                break
            case 2:
                if (indexPath.row) == 2{
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "EStoreViewController")
                    sideMenuController()?.setContentViewController(destViewController)
                    
                }
                break
            case 3:
                if (indexPath.row) == 3{
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "MyCarsViewController") as! MyCarsViewController
                        sideMenuController()?.setContentViewController(destViewController)
                    
                }
                break
            case 4:
                if (indexPath.row) == 4{
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "NewCarsViewController")
                    sideMenuController()?.setContentViewController(destViewController)
                }
                break
                
            case 5:
                if (indexPath.row) == 5{
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "UsedCarViewController")
                    sideMenuController()?.setContentViewController(destViewController)

                }
                break
                
            case 6:
                if (indexPath.row) == 2{
                        let MyRewardsVC = self.storyboard?.instantiateViewController(withIdentifier: "CompareViewController") as! CompareViewController
                        self.navigationController?.pushViewController(MyRewardsVC, animated: true)
//                        UserDefaults.standard.string(forKey: "token")
//                        print(UserDefaults.standard.string(forKey: "token"))
                    sideMenuController()?.setContentViewController(destViewController)
                }
                
               else if (indexPath.row) == 6{
                    
                    UserDefaults.standard.set(false, forKey: "car1")
                    UserDefaults.standard.set("no", forKey: "brandId1")
                    UserDefaults.standard.set("no", forKey: "modelId1")
                    UserDefaults.standard.set("no", forKey: "varientId1")
                    UserDefaults.standard.set("no", forKey: "brandName1")
                    UserDefaults.standard.set("no", forKey: "modelName1")
                    UserDefaults.standard.set("no", forKey: "varientName1")
                    UserDefaults.standard.set("no", forKey: "varientImage1")
                    
                    UserDefaults.standard.set(false, forKey: "car2")
                    UserDefaults.standard.set("no", forKey: "brandId2")
                    UserDefaults.standard.set("no", forKey: "modelId2")
                    UserDefaults.standard.set("no", forKey: "varientId2")
                    UserDefaults.standard.set("no", forKey: "brandName2")
                    UserDefaults.standard.set("no", forKey: "modelName2")
                    UserDefaults.standard.set("no", forKey: "varientName2")
                    UserDefaults.standard.set("no", forKey: "varientImage2")
                    
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "CompareViewController")
                    sideMenuController()?.setContentViewController(destViewController)

                }
                break
                
            case 7:
                if (indexPath.row) == 7{
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "NewsViewController")
                    sideMenuController()?.setContentViewController(destViewController)

                }
                break
                
            case 8:
                if (indexPath.row) == 8{
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoanAssistanceViewController")
                    sideMenuController()?.setContentViewController(destViewController)

                }
                break
                
            case 9:
                if (indexPath.row) == 9{
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "RoadAssistanceViewController")
                    sideMenuController()?.setContentViewController(destViewController)
                }
                break
                
            case 10:
                if (indexPath.row) == 10{
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "BrandHelplineViewController")
                    sideMenuController()?.setContentViewController(destViewController)

                                    }
                break
                
            case 11:
                if (indexPath.row) == 11{
                   
                    // Removing S
                    UserDefaults.standard.removeObject(forKey: "session")
                    UserDefaults.standard.removeObject(forKey: "token")
                    
                     let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                      self.present(SecVC, animated: true, completion: nil)
                }
                break
              
            default:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
                sideMenuController()?.setContentViewController(destViewController)

                break
                
            }
    }
    
    func skipItems(){
            let alert = UIAlertController(title: "Sorry ! You are not Loyalty User", message: "For using this feature you remove to be a loyalty User,Call to become one.", preferredStyle: UIAlertControllerStyle.alert)
            
            //Loyalty Details
            alert.addAction(UIAlertAction(title: "Loyalty Details", style: UIAlertActionStyle.default, handler: { action in
                switch action.style{
                case .default:
                    print("Loyalty Details")
                    let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "LoyaltyDetailViewController") as! LoyaltyDetailViewController
            
                    self.present(SecVC, animated: true, completion: nil)
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            
            //Loyalty Call
            self.present(alert, animated: true, completion: nil)
            alert.addAction(UIAlertAction(title: "Call", style: UIAlertActionStyle.default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                }}))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
    
    }
}
