//
//  RoadAssistanceViewController.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/17/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class RoadAssistanceViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var noItemView: UIView!
    var roadAssistanceList : [RoadAssistance] = [RoadAssistance]()
    var selectedMenuItem : Int = 0
    @IBOutlet var tableView2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView2.backgroundView = noItemView
        noItemView.isHidden = true
        self.sideMenuController()?.sideMenu?.delegate = MySideMenu()
        getRoadAssistanceList()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func noData(){
        if tableView2.visibleCells.isEmpty{
            noItemView.isHidden = false
            tableView2.separatorStyle = .none
        }else {
            noItemView.isHidden = true
            tableView2.separatorStyle = .singleLine
        }
    }
    
    func getRoadAssistanceList(){
        self.view.makeToastActivity(.center)
            let token : String = UserDefaults.standard.string(forKey: "token")!
            // Parameters
            let parameters: [String: Any] = ["token":token]
            
            //Alamofire Request
            Alamofire.request(WebUrl.ROAD_ASSISTANCE_URL, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
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
                        let roadsideasttList = i["roadsideasttList"].array // Read Json Object
                        
                        for dataModel in roadsideasttList! {      // Parse Json Array
                            
                          let id = dataModel["id"].stringValue
                          let contact = dataModel["contact"].stringValue
                          let location = dataModel["location"].stringValue
                            
                            print("MyLocation : \(location)" + "    MyConatct : \(contact)" + "     MyID : \(id)" )
                            
                  self.roadAssistanceList.append(RoadAssistance(id: id, contact: contact, location: location))

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
        
        return roadAssistanceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = Bundle.main.loadNibNamed("RoadSideAssistanceTableViewCell", owner: self, options: nil)?.first as!RoadSideAssistanceTableViewCell
            cell2.RoadLbl.text = roadAssistanceList[indexPath.row].location
            cell2.mobNoAssistance = roadAssistanceList[indexPath.row].contact
            return cell2
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 235;//Choose your custom row height
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func HometoggleSideMenuBtn(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
        print("Home Menu Button")
    }
  
}

