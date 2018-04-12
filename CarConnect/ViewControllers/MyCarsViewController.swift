//
//  MyCarsViewController.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/17/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import AlamofireImage

class MyCarsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var selectedMenuItem : Int = 0
    //var arrayofcelldata2 = [CellData2]()
    @IBOutlet var tableView2: UITableView!
    var myList : [MyCars] = [MyCars]()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        getMyCarList()
        self.sideMenuController()?.sideMenu?.delegate = MySideMenu()
    }
   
    
func getMyCarList(){
    let userId : String = UserDefaults.standard.string(forKey: "userId")!
    let mobile : String = UserDefaults.standard.string(forKey: "mobile")!
    
// Parameters
        let parameters: [String: Any] = ["userId":userId, "userMobile": mobile]
    
//Alamofire Request
        Alamofire.request(WebUrl.MY_CAR_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            print("NewCarJsonResponse: \(response)")

/*****************Response Success *****************/
            switch response.result {
    
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let myCarList = JSON(i)// Read Json Object
                    let filterlist = myCarList["filterlist"].array   // Read Json Array
                    
                 for dataModel in filterlist! {      // Parse Json Array
                    let chassNo = dataModel["chassNo"].stringValue
                    let usermobile = dataModel["usermobile"].stringValue
                    let image = dataModel["modelImage"].stringValue
                    let expiryDate = dataModel["expiryDate"].stringValue
                    let loyaltyId = dataModel["loyaltyId"].stringValue
                    let colorCode = dataModel["colorCode"].stringValue
                    let variantName = dataModel["variantName"].stringValue
                    let brandName = dataModel["brandName"].stringValue
                    let location = dataModel["location"].stringValue
                    let registrationNo = dataModel["registrationNo"].stringValue
                    let modelYear = dataModel["modelYear"].stringValue
                    let modelName = dataModel["modelName"].stringValue
                    let updated_at = dataModel["updated_at"].stringValue
                    let updatedBy = dataModel["updatedBy"].stringValue
                    let created_at = dataModel["created_at"].stringValue
                    let updatedType = dataModel["updatedType"].stringValue
                    let id = dataModel["id"].stringValue

                    let modelImage = WebUrl.MODEL_IMAGE_URL+image
                    print(brandName)

                    self.myList.append(MyCars(chassNo: chassNo,usermobile: usermobile, modelImage: modelImage, updated_at: updated_at, expiryDate: expiryDate, loyaltyId: loyaltyId, colorCode: colorCode, variantName: variantName, brandName: brandName, updatedBy: updatedBy, location: location, updatedType: updatedType, id: id, status: status, registrationNo: registrationNo, created_at: created_at, modelYear: modelYear, modelName: modelName))
                    
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
    
@IBAction func HometoggleSideMenuBtn(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
        print("Home Menu Button")
    }
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell2 = Bundle.main.loadNibNamed("MyCarTableViewCell", owner: self, options: nil)?.first as! MyCarTableViewCell
        
            let url = URL(string: myList[indexPath.row].modelImage)!
             cell2.MyCarCellImageView.af_setImage(withURL: url)

            cell2.MyCarCellLabel1.text = myList[indexPath.row].brandName
            cell2.MyCarCellLabel2.text = myList[indexPath.row].modelName
            return cell2
     
    }
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 325;
    }
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let MyCarsVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCarsDetailViewController") as! MyCarsDetailViewController
        MyCarsVC.carId = myList[indexPath.row].id
        MyCarsVC.brandName = myList[indexPath.row].brandName
        MyCarsVC.varientNAme = myList[indexPath.row].variantName
        MyCarsVC.modelName = myList[indexPath.row].modelName
        MyCarsVC.image1 = myList[indexPath.row].modelImage
       self.present(MyCarsVC, animated: true, completion: nil)
    
    
}
    }
   

