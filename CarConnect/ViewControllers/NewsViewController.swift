//
//  NewsViewController
//  CarConnect
//
//  Created by Saurabh Sharma on 10/17/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift

struct CellData5 {
    
    let cell2 : Int!
    let image : UIImage!
    let text1 : String!
    let text2 : String!
    
}

class NewsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    
    var selectedMenuItem : Int = 0
    var newsList : [NewsStruct] = [NewsStruct]()
    @IBOutlet var tableView2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sideMenuController()?.sideMenu?.delegate = MySideMenu()
        getNewsList()
        print(UserDefaults.standard.string(forKey: "token"))
        
    }
   
    func getNewsList(){
        
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        
        // Parameters
        let parameters: [String: Any] = ["token":token]
        
        //Alamofire Request
        Alamofire.request(WebUrl.NEWS_LIST_URL, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            // print("NewCarJsonResponse: \(response.result)")
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let newsList = i["newsList"] as JSON // Read Json Object
                    let datalist = newsList["data"].array
                    
                    
                    
                    for dataModel in datalist! {      // Parse Json Array
                        let description = dataModel["description"].stringValue
                        let title = dataModel["title"].stringValue
                        let id = dataModel["id"].stringValue
                        let image = dataModel["image"].stringValue
                        let created_at = dataModel["created_at"].stringValue
                        
                        let myimage = WebUrl.NEWS_IMAGE_URL+image
                        
                        
                       
                        self.newsList.append(NewsStruct(description: description, title: title, id: id, image: myimage, created_at: created_at))

                        
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
        
        return newsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell2 = Bundle.main.loadNibNamed("NewsCell", owner: self, options: nil)?.first as!
            NewsCell
        
            let url = URL(string: newsList[indexPath.row].image)!
            cell2.NewsCellImageView.af_setImage(withURL: url)
        
            cell2.NewsLbl1.text = newsList[indexPath.row].title
            cell2.NewsLbl2.text = newsList[indexPath.row].description
            return cell2
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 335;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var destViewController : UIViewController
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "NewsViewController")
        
        let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
                SecVC.newsImage = self.newsList[indexPath.row].image
                SecVC.newsTitle = self.newsList[indexPath.row].title
                SecVC.newsDesc = self.newsList[indexPath.row].description
                self.present(SecVC, animated: true, completion: nil)

    }
    
    @IBAction func HometoggleSideMenuBtn(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
    }

    
}


