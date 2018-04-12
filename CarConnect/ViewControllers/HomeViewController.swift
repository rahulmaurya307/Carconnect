//
//  HomeViewController.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/4/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift

class HomeViewController: UIViewController {
    
    @IBOutlet var lblNews: UILabel!
    @IBOutlet var imgvwNews: UIImageView!
    @IBOutlet var lblUsedCar: UILabel!
    @IBOutlet var imgvwUsedCar: UIImageView!
    @IBOutlet var lblNewCar: UILabel!
    @IBOutlet var imgvwNewCars: UIImageView!
    @IBOutlet weak var HomeScrollView: UIScrollView!
    var imageArray = [UIImage]()
    var skipLog : String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getProfile()
        getHomeDetail()
       // imageArray = [#imageLiteral(resourceName: "car5"),#imageLiteral(resourceName: "Car2"),#imageLiteral(resourceName: "Car3"),#imageLiteral(resourceName: "car5"),]
       
        
    }
    @IBAction func btnMyRewards(_ sender: Any) {
        let MyRewardsVC = self.storyboard?.instantiateViewController(withIdentifier: "MyRewardsViewController") as! MyRewardsViewController
        self.navigationController?.pushViewController(MyRewardsVC, animated: true)
        UserDefaults.standard.string(forKey: "token")
        print(UserDefaults.standard.string(forKey: "token"))
        
    }
    
    @IBAction func btnEstore(_ sender: Any) {
        
        let EstoreVC = self.storyboard?.instantiateViewController(withIdentifier: "EStoreViewController") as! EStoreViewController
        self.navigationController?.pushViewController(EstoreVC, animated: true)
        
    }
    
    @IBAction func btnMyCars(_ sender: Any) {
        let MyCarsVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCarsViewController") as! MyCarsViewController
        self.navigationController?.pushViewController(MyCarsVC, animated: true)
    }
    func skipItems(){
        let skipLog : String! = UserDefaults.standard.string(forKey: "skipLog")!
        if skipLog == "skipLog"{
            
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
    
    @IBAction func btnCompare(_ sender: Any) {
        
        let CompareVC = self.storyboard?.instantiateViewController(withIdentifier: "CompareViewController") as! CompareViewController
        self.navigationController?.pushViewController(CompareVC, animated: true)
        
    }
    
    @IBAction func btnPopularCar(_ sender: Any) {
        
        let PopularCarVC = self.storyboard?.instantiateViewController(withIdentifier: "NewCarsViewController") as! NewCarsViewController
        self.navigationController?.pushViewController(PopularCarVC, animated: true)
        
    }
    
    @IBAction func btnPopularUsed(_ sender: Any) {
        let PopularUsedVC = self.storyboard?.instantiateViewController(withIdentifier: "UsedCarViewController") as! UsedCarViewController
        self.navigationController?.pushViewController(PopularUsedVC, animated: true)
    }
    

    
    @IBAction func btnNewsHome(_ sender: Any) {
        let NewsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        self.navigationController?.pushViewController(NewsVC, animated: true)
        
    }
    
    func getHomeDetail(){
        self.view.makeToastActivity(.center)
        var image : String!
        var title : String!
        var brandName : String!
        var modelName : String!
        var modelImage : String!
        var usedModelName : String!
        var usedBrandName : String!
        var vehicleImages1 : String!
        
        let token : String = UserDefaults.standard.string(forKey: "token")!
        // Parameters
        let parameters: [String: Any] = ["token":token]
        
        //Alamofire Request
        Alamofire.request(WebUrl.HOME_PAGE_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("Home JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let homeList = i["homeList"].array! // Read Json Object
                    let newsList = homeList[0] as JSON
                    let newsListArray = newsList["newsList"].array
                    for i in newsListArray! {
                        // news Array
                        var description = i["description"].stringValue
                        title = i["title"].stringValue
                        var id = i["id"].stringValue
                        image = i["image"].stringValue
                        
                        
                    }
                    
                    let newCarArray = newsList["newcarList"].array
                    for i in newCarArray! {
                        // new car Array
                        
                        var id = i["id"].stringValue
                        var price = i["price"].stringValue
                        brandName = i["brandName"].stringValue
                        modelName = i["modelName"].stringValue
                        modelImage = i["modelImage"].stringValue
                        
                        
                    }
                    
                    let usedCarArray = newsList["usedcarList"].array
                    for i in usedCarArray! {
                        // Used Car Array
                        usedModelName = i["modelName"].stringValue
                        var state = i["state"].stringValue
                        var carId = i["carId"].stringValue
                        var updated_at = i["updated_at"].stringValue
                        var vehicleImages2 = i["vehicleImages2"].stringValue
                        var variantName = i["variantName"].stringValue
                        var kmsdriven = i["kmsdriven"].stringValue
                        usedBrandName = i["brandName"].stringValue
                        var color = i["color"].stringValue
                        var carStatus = i["carStatus"].stringValue
                        var status = i["status"].stringValue
                        var updatedBy = i["updatedBy"].stringValue
                        var updatedType = i["updatedType"].stringValue
                        var id = i["id"].stringValue
                        vehicleImages1 = i["vehicleImages1"].stringValue
                        var vehicleImages3 = i["vehicleImages3"].stringValue
                        var created_at = i["created_at"].stringValue
                        var modelYear = i["modelYear"].stringValue
                        var owner = i["owner"].stringValue
                        var price = i["price"].stringValue
                        var comment = i["comment"].stringValue
                        var dealerId = i["dealerId"].stringValue
                        var registration = i["registration"].stringValue
                        
                        print(vehicleImages1)
                    }
                    if (image != nil){
                    let myNewsImage = WebUrl.NEWS_IMAGE_URL+image
                    let newsurl = URL(string: myNewsImage)!
                    self.imgvwNews.af_setImage(withURL: newsurl)
                    }
                    self.lblNews.text = title
                    
                    if(modelImage != nil){
                    let myNewCarsImage = WebUrl.NEW_CARS + modelImage
                    let newCarurl = URL(string: myNewCarsImage)!
                    self.imgvwNewCars.af_setImage(withURL: newCarurl)
                    }
                    self.lblNewCar.text = brandName + "(" + modelName + ")"
                    
                    if (vehicleImages1 != nil){
                    let myUsedCarsImage = WebUrl.USED_CAR_IMAGE_URL+vehicleImages1
                    let url = URL(string: myUsedCarsImage)!
                    self.imgvwUsedCar.af_setImage(withURL: url)
                    self.lblUsedCar.text = brandName + "(" + modelName + ")"
                    }
                }
            }
                
            //Network Error
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }
    
   
    
    @IBAction func HometoggleSideMenuBtn(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
    @IBAction func btnViewUsedCar(_ sender: Any) {
        
        let PopularUsedVC = self.storyboard?.instantiateViewController(withIdentifier: "UsedCarViewController") as! UsedCarViewController
        self.navigationController?.pushViewController(PopularUsedVC, animated: true)
    }
    @IBAction func btnViewAllNewCar(_ sender: Any) {
        let PopularCarVC = self.storyboard?.instantiateViewController(withIdentifier: "NewCarsViewController") as! NewCarsViewController
        self.navigationController?.pushViewController(PopularCarVC, animated: true)
    }
    
}
