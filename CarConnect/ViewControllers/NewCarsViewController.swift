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


class NewCarsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var noItemsView: UIView!
    var cardID : Int!
    
    var selectedMenuItem : Int = 0
    var newCarList : [NewCars] = [NewCars]()
    @IBOutlet var tableView2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView2.backgroundView = noItemsView
        noItemsView.isHidden = true
        getNewCarList()
        self.sideMenuController()?.sideMenu?.delegate = MySideMenu()
    }
 
    func noData(){
        if tableView2.visibleCells.isEmpty{
            noItemsView.isHidden = false
        }else {
            noItemsView.isHidden = true
        }
    }
    
    func getNewCarList(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!

        // Parameters
        let parameters: [String: Any] = ["":""]

        //Alamofire Request
        Alamofire.request(WebUrl.NEW_CAR_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
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
                    let newCarList = i["newcarList"] as JSON // Read Json Object
                    let datalist = newCarList["data"].array
                    
                    for dataModel in datalist! {      // Parse Json Array
                        let modelImage = dataModel["modelImage"].stringValue
                        let id = dataModel["id"].stringValue
                        let price = dataModel["price"].stringValue
                        let brandName = dataModel["brandName"].stringValue
                        let modelName = dataModel["modelName"].stringValue
                        let myimage = WebUrl.MODEL_IMAGE_URL+modelImage
                        
                        self.newCarList.append(NewCars(modelImage: myimage, id: id, price: price, brandName: brandName, modelName: modelName))
                    }

                    self.tableView2.reloadData()
                    self.noData()

                    }
                }
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }

        
        
    }
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newCarList.count
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell2 = Bundle.main.loadNibNamed("MyCarTableViewCell", owner: self, options: nil)?.first as! MyCarTableViewCell
    
                let url = URL(string: newCarList[indexPath.row].modelImage)!
                cell2.MyCarCellImageView.af_setImage(withURL: url)
    
                cell2.MyCarCellLabel1.text = newCarList[indexPath.row].brandName+"( "+newCarList[indexPath.row].modelName+" )"
    
//     cell2.MyCarCellLabel2.text = "₹ " + String(Double(newCarList[indexPath.row].price)!) + " Lakh"
    
    if(Int(newCarList[indexPath.row].price)! < 9999999){
        cell2.MyCarCellLabel2.text = "₹ " + String(Double(newCarList[indexPath.row].price)! / 100000 ) + " Lakh"
    }else  if(Int(newCarList[indexPath.row].price)! > 9999999){
        cell2.MyCarCellLabel2.text = "₹ " + String(Double(newCarList[indexPath.row].price)! / 1000000 ) + " Crore"
    }
    
            return cell2
            
    }
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 330;//Choose your custom row height
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        
        let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "BrandDetailViewController") as! BrandDetailViewController
        SecVC.carID = newCarList[indexPath.row].id
        //SecVC.location = newCarList[indexPath.row]
        self.present(SecVC, animated: true, completion: nil)
       
    }
    
    @IBAction func HometoggleSideMenuBtn(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
        print("Home Menu Button")
    }
    
    
}

