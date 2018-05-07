
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift

class CompareViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableViewDetail: UITableView!
    
    @IBOutlet var viewSelectCar1: CardView!
   
    @IBOutlet var viewSelectCar2: CardView!
    
    @IBOutlet var btnSelect1: UIButton!
    
    @IBOutlet var btnSelect2: UIButton!
    
    @IBOutlet var btnComapare: UIButton!
    
    @IBOutlet var view1CarName: UIView!
    
    @IBOutlet var view2CarName: UIView!
    
    @IBOutlet var txvw1CarName: UILabel!
    
    @IBOutlet var txtvw2CarName: UILabel!
    
    @IBOutlet var segmentControll: UISegmentedControl!
    
    
    @IBOutlet var imgvwCar1: UIImageView!
    
    @IBOutlet var lblCarName1: UILabel!
    
    @IBOutlet var lbl2CarModel1: UILabel!
    
    @IBOutlet var lblCarVarient1: UILabel!
    @IBOutlet var imgvwCar2: UIImageView!
    
    @IBOutlet var lblCarName2: UILabel!
    
    @IBOutlet var lbl2CarModel2: UILabel!
    
    @IBOutlet var lblCarVarient2: UILabel!
    
    @IBOutlet var view1WithData: UIView!
    
    @IBOutlet var view2WithData: UIView!
    
    @IBOutlet var viewTableSegment: UIView!
   
    var SpeciFicationList : [CompareCarModel] = [CompareCarModel]()
    var overViewList : [CompareCarModel] = [CompareCarModel]()
    var featureList : [CompareCarModel] = [CompareCarModel]()
    var brandId : String!
    var modelId : String!
    var brandName : String!
    var modelName : String!
    var varientImage : String!
    var flag : String!
    var varientName : String!
    var i : Int! = 0
    var j : Int! = 0
    
    override func viewWillAppear(_ animated: Bool) {
         self.sideMenuController()?.sideMenu?.delegate = MySideMenu()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view1CarName.isHidden = true
        view2CarName.isHidden = true
        view1WithData.isHidden = true
        view2WithData.isHidden = true
        viewTableSegment.isHidden = true
        
        let car1 : Bool = UserDefaults.standard.bool(forKey: "car1")
        let car2 : Bool = UserDefaults.standard.bool(forKey: "car2")
        
       
        if (car1 == true) {
            i = 1
            viewSelectCar1.isHidden = true
            view1WithData.layer.borderWidth = 0.5
            view1WithData.isHidden = false
            lblCarName1.text = UserDefaults.standard.string(forKey: "brandName1")!
            lbl2CarModel1.text = UserDefaults.standard.string(forKey: "modelName1")!
            lblCarVarient1.text = UserDefaults.standard.string(forKey: "varientName1")!
            
            let url = URL(string: UserDefaults.standard.string(forKey: "varientImage1")!)
            imgvwCar1.af_setImage(withURL: url!)
            print("carrrrrrr1 :\(car1)")
            print("carrrrrrr1 :\(car2)")
        }
        if (car2 == true) {
            j = 1
            viewSelectCar2.isHidden = true
            view2WithData.layer.borderWidth = 0.5
            view2WithData.isHidden = false
            lblCarName2.text = UserDefaults.standard.string(forKey: "brandName2")!
            lbl2CarModel2.text = UserDefaults.standard.string(forKey: "modelName2")!
            lblCarVarient2.text = UserDefaults.standard.string(forKey: "varientName2")!
            
            let url = URL(string: UserDefaults.standard.string(forKey: "varientImage2")!)
            imgvwCar2.af_setImage(withURL: url!)
            print(flag)
            print("carrrrrrr2 :\(car1)")
            print("carrrrrrr2 :\(car2)")
        }
    }

    @IBAction func BtnRepeatSelectCar1(_ sender: Any) {
        let otpvc = self.storyboard?.instantiateViewController(withIdentifier: "SelectBrandViewController") as! SelectBrandViewController
        otpvc.flag = "car1"
        self.present(otpvc, animated: true, completion: nil)
        
    }
    
    @IBAction func BtnRepeatSelectCar2(_ sender: Any) {
        let otpvc = self.storyboard?.instantiateViewController(withIdentifier: "SelectBrandViewController") as! SelectBrandViewController
        otpvc.flag = "car2"
        self.present(otpvc, animated: true, completion: nil)
    }
    
    @IBAction func btnComapare(_ sender: Any) {
        let car1 : String = UserDefaults.standard.string(forKey: "varientName1")!
        let car2 : String = UserDefaults.standard.string(forKey: "varientName2")!
        
        if(i == 0){
            self.view.makeToast("You not selected any car")
        }else  if(j == 0){
            self.view.makeToast("Please select second car to proceed")
        }else  if(car1 == car2){
            self.view.makeToast("Please select different varient")
        }else{
            
            getCompareData()
            
            viewTableSegment.isHidden = false
            btnComapare.isHidden = true
            view1CarName.isHidden = false
            view2CarName.isHidden = false
            viewTableSegment.isHidden = false
            
        txvw1CarName.text = UserDefaults.standard.string(forKey: "modelName1")! + " (" +
            UserDefaults.standard.string(forKey: "varientName1")! + " )"
            txtvw2CarName.text = UserDefaults.standard.string(forKey: "modelName2")! + " (" + UserDefaults.standard.string(forKey: "varientName2")! + " )"
        
        }
        
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    @IBAction func BtnSelect1(_ sender: Any) {
        
        let otpvc = self.storyboard?.instantiateViewController(withIdentifier: "SelectBrandViewController") as! SelectBrandViewController
             otpvc.flag = "car1"
            self.present(otpvc, animated: true, completion: nil)
        
    }
    
    @IBAction func BtnSelect2(_ sender: Any) {
         let otpvc = self.storyboard?.instantiateViewController(withIdentifier: "SelectBrandViewController") as! SelectBrandViewController
         otpvc.flag = "car2"
         self.present(otpvc, animated: true, completion: nil)
    }
    
    @IBAction func HometoggleSideMenuBtn(_ sender:UIBarButtonItem) {
        toggleSideMenuView()
    }
    
    @IBAction func segmentControll(_ sender: Any) {
        
        switch (segmentControll.selectedSegmentIndex) {
        case 0:
            tableViewDetail.reloadData()
            break
        case 1:
            tableViewDetail.reloadData()
            break
        case 2:
            tableViewDetail.reloadData()
            break
        default:
            break
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (segmentControll.selectedSegmentIndex) {
        case 0:
            return overViewList.count
        case 1:
            return SpeciFicationList.count
        case 2:
            return featureList.count
        default:
            break
        }
        return overViewList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (segmentControll.selectedSegmentIndex) {
        case 0:
            print("Cell1")
            let cell2 = Bundle.main.loadNibNamed("ComapareCarCell", owner: self, options: nil)?.first as! ComapareCarCell
            cell2.lblCompareName.text = overViewList[indexPath.row].name
            cell2.lblCompareCar1.text = overViewList[indexPath.row].carOne
            cell2.lblCompareCar2.text = overViewList[indexPath.row].carTwo
            
            return cell2
            
        case 1:
            print("Cell2")
            let cell2 = Bundle.main.loadNibNamed("ComapareCarCell", owner: self, options: nil)?.first as! ComapareCarCell
            cell2.lblCompareName.text = SpeciFicationList[indexPath.row].name
            cell2.lblCompareCar1.text = SpeciFicationList[indexPath.row].carOne
            cell2.lblCompareCar2.text = SpeciFicationList[indexPath.row].carTwo
            
            return cell2
            
        case 2:
            print("Cell3")
            let cell2 = Bundle.main.loadNibNamed("ComapareCarCell", owner: self, options: nil)?.first as! ComapareCarCell
            cell2.lblCompareName.text = featureList[indexPath.row].name
            cell2.lblCompareCar1.text = featureList[indexPath.row].carOne
            cell2.lblCompareCar2.text = featureList[indexPath.row].carTwo
          
            return cell2
            
        default:
            break
        }
        let cell2 = Bundle.main.loadNibNamed("ComapareCarCell", owner: self, options: nil)?.first as! ComapareCarCell
        cell2.lblCompareName.text = overViewList[indexPath.row].name
        cell2.lblCompareCar1.text = overViewList[indexPath.row].carOne
        cell2.lblCompareCar2.text = overViewList[indexPath.row].carTwo
        return cell2
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return 75;//Choose your custom row height
//    }
    
    
    func getCompareData() {
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let varientId1 : String = UserDefaults.standard.string(forKey: "varientId1")!
        let varientId2 : String = UserDefaults.standard.string(forKey: "varientId2")!
        
        // Parameters
        let parameters: [String: Any] = ["varientIdOne":varientId1, "varientIdTwo":varientId2]
        
        //Alamofire Request
        Alamofire.request(WebUrl.COMPARE_LIST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
    /*****************Response Success *****************/
            
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array!
                for var i in (0..<data.count)
                    {
                        // Specifications Array
                        let specificationData = data[0] as JSON
                        let specificationArray = specificationData["specification"].array!
                        for i in specificationArray {
                            var name = i["name"].stringValue
                            var carOne = i["carOne"].stringValue
                            var carTwo = i["carTwo"].stringValue
                            self.SpeciFicationList.append(CompareCarModel(name: name, carOne: carOne, carTwo: carTwo))
                           
                        }
                        
                        //overview Data
                       // let overviewData = data[1] as JSON
                        let overviewArray = specificationData["overview"].array!
                        for i in overviewArray {
                            var name = i["name"].stringValue
                            var carOne = i["carOne"].stringValue
                            var carTwo = i["carTwo"].stringValue
                            self.overViewList.append(CompareCarModel(name: name, carOne: carOne, carTwo: carTwo))
                            
                        }
                        
                        //Feature Data
                       // let featureData = data[2] as JSON
                        let featureArray = specificationData["feature"].array!
                        for i in featureArray {
                            var name = i["name"].stringValue
                            var carOne = i["carOne"].stringValue
                            var carTwo = i["carTwo"].stringValue
                            self.featureList.append(CompareCarModel(name: name, carOne: carOne, carTwo: carTwo))
                            
                            
                        }
                    
                    self.tableViewDetail.reloadData()
                }
    
                
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }

}
