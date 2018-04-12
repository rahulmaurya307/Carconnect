//
//  SelectBrandViewController.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/17/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
import Toast_Swift


class SelectBrandViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var noItemView: UIView!
    var carName : String!
    var selectedMenuItem : Int = 0
    @IBOutlet var tableView2: UITableView!
    var selectCarList : [SelectCar] = [SelectCar]()
    var brandId : String!
    var flag : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectcar1()
        self.sideMenuController()?.sideMenu?.delegate = MySideMenu()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectModelViewController") as! SelectModelViewController
            SecVC.brandId = selectCarList[indexPath.row].id
            SecVC.brandName = selectCarList[indexPath.row].brandName
            SecVC.flag = flag
            self.present(SecVC, animated: true, completion: nil)
        
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
/**************************** Select Car 1 ******************************/
    func selectcar1(){
        self.view.makeToastActivity(.center)
        
        let token : String = UserDefaults.standard.string(forKey: "token")!
        // Parameters
        let parameters: [String: Any] = ["token":token]
       
        //Alamofire Request
        Alamofire.request(WebUrl.BRAND_LIST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            /*****************Response Success *****************/
            
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                for i in data! {
                    let brandList = i["brandList"] as JSON // Read Json Object
                    print("braaaandd: \(brandList)")
                    let data2 = brandList["data"].array
                    print("data2222 : \(data2!)")
                    
                                    for j in data2!{
                                    var id = j["id"].stringValue
                                    var brandImage = j["brandImage"].stringValue
                                    var brandName = j["brandName"].stringValue
                                   
                        self.selectCarList.append(SelectCar(id: id, brandImage: brandImage, brandName: brandName))
                        
                      
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


