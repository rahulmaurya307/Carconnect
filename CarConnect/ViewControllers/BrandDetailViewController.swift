

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift


class BrandDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var noItemsView: UIView!
    
    
    /*******IDs*******/
    var imageurl : URL!
    @IBOutlet var imgvwCar: UIImageView!
    @IBOutlet var lblCarName: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var SegmentControl: UISegmentedControl!
    
    var mobileNumber : String!
    var dealerMobile : String!
    var carID : String!
    var location : String!
    var imageList : [ImageModelBD] = [ImageModelBD]()
    var fuelList : [FuelModelBD] = [FuelModelBD]()
    var colorList : [ColorModelBD] = [ColorModelBD]()
    var varientList : [VarientListModel] = [VarientListModel]()
    var myPrice : String!
    
    
    
    @IBOutlet var tableView2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var fuelId : Int = 0
        self.sideMenuController()?.sideMenu?.delegate = MySideMenu()
        print("MyMobileNo: \(mobileNumber)")
        getBrandDetails()
        
        varientList.removeAll()
        for (index, item) in fuelList.enumerated()
        {
            if(0 == index){
                print("Value at index = \(index) is \(item.id)")
                fuelId = Int(item.id)!
            }
        }
        getVariantData(fuelId: fuelId)
        tableView2.backgroundView = noItemsView
        noItemsView.isHidden = true
    }
   
    
   
    func noData(){
        if tableView2.visibleCells.isEmpty{
            noItemsView.isHidden = false
        }else {
            noItemsView.isHidden = true
        }
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return colorList.count
        
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for:indexPath) as! ColorCollectionViewCell
        let color = colorList[indexPath.row].colorCode!
        print(color)
        cell.myView.backgroundColor = UIColor(hexString: color+"FF")
        cell.myView.makeCircular()
        
        
        return cell
    }
    
    @IBAction func btnCall(_ sender: Any) {
        print(dealerMobile)
        if let url = URL(string: "tel://"+dealerMobile), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    @IBAction func SegmentControl(_ sender: Any) {
        var fuelId : Int = 0
        switch (SegmentControl.selectedSegmentIndex) {
        case 0:
            varientList.removeAll()
            for (index, item) in fuelList.enumerated()
            {
                if(0 == index){
                    print("Value at index = \(index) is \(item.id)")
                    fuelId = Int(item.id)!
                }
            }
            
            getVariantData(fuelId: fuelId)
            print(fuelId)
            self.tableView2.reloadData()
            break
            
        case 1:
            varientList.removeAll()
            for (index, item) in fuelList.enumerated()
            {
                
                if(1 == index){
                    print("Value at index = \(index) is \(item.id)")
                    fuelId = Int(item.id)!
                }
            }
            
            getVariantData(fuelId: fuelId)
            print(fuelId)
            self.tableView2.reloadData()
            break
            
        case 2:
            varientList.removeAll()
            for (index, item) in fuelList.enumerated()
            {
                
                if(2 == index){
                    print("Value at index = \(index) is \(item.id)")
                    fuelId = Int(item.id)!
                }
            }
            
            getVariantData(fuelId: fuelId)
            print(fuelId)
            self.tableView2.reloadData()
            break
            
        case 3:
            varientList.removeAll()
            for (index, item) in fuelList.enumerated()
            {
                
                if(3 == index){
                    print("Value at index = \(index) is \(item.id)")
                    fuelId = Int(item.id)!
                }
            }
            
            getVariantData(fuelId: fuelId)
            print(fuelId)
            self.tableView2.reloadData()
            
            break
            
        default:
            break
        }
    }
    
    
    @IBAction func backBtn (_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnBookDrive(_ sender: Any) {
        
        let  BookVC = self.storyboard?.instantiateViewController(withIdentifier: "BookTestDriveViewController") as! BookTestDriveViewController
        BookVC.carId = carID
        self.present(BookVC, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return varientList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2 = Bundle.main.loadNibNamed("BrandDetailTableViewCell", owner: self, options: nil)?.first as!
        BrandDetailTableViewCell
        
        
        print("varientList: \(varientList.count)")
        
        if(varientList.isEmpty){
            
            print("ppppppppppp")
            
        }else{
            print("rrrrrrrrrrr: \(varientList[indexPath.row].variantName)")
            
            cell2.LblCarName.text = varientList[indexPath.row].variantName
            cell2.LblEngine.text = varientList[indexPath.row].variantPower + " cc " + " " + varientList[indexPath.row].variantmileage + " kmpl "
            //cell2.LblShowroom.text = " Ex-showroom Price " + varientList[indexPath.row].price + " Lakh"
            
            if(Int(varientList[indexPath.row].price)! < 9999999){
                cell2.LblShowroom.text = "₹ " + String(Double(varientList[indexPath.row].price)! / 100000 ) + " Lakh"
            }else  if(Int(varientList[indexPath.row].price)! > 9999999){
                 cell2.LblShowroom.text = "₹ " + String(Double(varientList[indexPath.row].price)! / 1000000 ) + " Crore"
            }
        }
        return cell2
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let bsVC = self.storyboard?.instantiateViewController(withIdentifier: "BrandSpecificationViewController") as! BrandSpecificationViewController
        bsVC.carId = carID
        bsVC.varientId = varientList[indexPath.row].id
        bsVC.ModelName = varientList[indexPath.row].variantName
        bsVC.mobileNumber = self.mobileNumber
        bsVC.price = myPrice
        bsVC.dealerMobile = dealerMobile
        bsVC.imageUrl = imageList[indexPath.row].modelImage
        self.present(bsVC, animated: true, completion: nil)
    }
    
    @objc func getBrandDetails(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        // Parameters
        let parameters: [String: Any] = ["carId":carID]
        
        //Alamofire Request
        Alamofire.request(WebUrl.NEW_CAR_DETAIL_LIST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            // print("NewCarJsonResponse: \(response.result)")
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for dataModel in data! {      // Parse Json Array
                    // Image data
                    
                    var modelImage : String!
                    let modelImageArray = dataModel["modelImage"].array!
                    for image in modelImageArray{
                        let id = image["id"].stringValue
                        modelImage = image["modelImage"].stringValue
                        
                        self.imageList.append(ImageModelBD(id: id, modelImage: modelImage))
                    }
                    
                    if(modelImage != nil){
                        for var i in (0...modelImageArray.count)
                        {
                            let image = modelImageArray[0] as JSON
                            let myimage3 = WebUrl.NEW_CARS + image["modelImage"].stringValue
                            self.imageurl = URL(string: myimage3)
                            self.imgvwCar.af_setImage(withURL: self.imageurl!)
                        }
                    }
                    else{
                        self.view.makeToast("No data Found")
                    }
                    
                    
                    // fuel data
                    let fuelArray = dataModel["FuelList"].array
                    for fuel in fuelArray!{
                        let id = fuel["id"].stringValue
                        let fuelType = fuel["fuelType"].stringValue
                        
                        self.fuelList.append(FuelModelBD(id: id, fuelType: fuelType))
                        
                        
                    }
                    
                    // Car data
                    let filterlist = dataModel["filterlist"].array
                    for carData in filterlist!{
                        let id = carData["id"].stringValue
                        self.dealerMobile = carData["dealerMobile"].stringValue
                        let price : Int? =  carData["price"].intValue
                        let modelName = carData["modelName"].stringValue
                        
                        self.lblCarName.text = modelName
                        //self.lblPrice.text = price
                        
                        if(price! < 9999999){
                            self.lblPrice.text = "₹ " + String(Double(price!) / 100000 ) + " Lakh"
                            self.myPrice = "₹ " + String(Double(price!) / 100000 ) + " Lakh"
                        }else if(price! > 9999999){
                            self.lblPrice.text = "₹ " + String(Double(price!) / 1000000 ) + " Crore"
                             self.myPrice = "₹ " + String(Double(price!) / 1000000 ) + " Crore"
                        }
                        
                        
                    }
                    
                    // color data
                    let colorArray = dataModel["colorList"].array
                    for color in colorArray!{
                        let id = color["id"].stringValue
                        let colorName = color["colorName"].stringValue
                        let colorCode = color["colorCode"].stringValue
                        
                        self.colorList.append(ColorModelBD(id: id, colorName: colorName, colorCode: colorCode))
                    }
                }
                self.collectionView.reloadData()
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
        
    }
    
    
    
    func getVariantData(fuelId : Int)  {
        let token : String = UserDefaults.standard.string(forKey: "token")!
        // Parameters
        let parameters: [String: Any] = ["modelId":carID!, "fuelId":fuelId]
        
        print("CAR ID :\(carID)")
        print("FUEL ID :\(fuelId)")
        
        //Alamofire Request
        Alamofire.request(WebUrl.VARIANT_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            /*****************Response Success *****************/
            
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                for i in data! {
                    let filterlist = i["filterlist"].array // Read Json Object
                    
                    for dataModel in filterlist! {      // Parse Json Array
                        let variantId = dataModel["variantId"].stringValue
                        let variantName = dataModel["variantName"].stringValue
                        let price = dataModel["price"].stringValue
                        let variantmileage = dataModel["variantmileage"].stringValue
                        let variantPower = dataModel["variantPower"].stringValue
                        
                        self.varientList.append(VarientListModel(id: variantId, variantName: variantName, variantPower: variantPower, variantmileage: variantmileage, price: price))
                        
                    }
                }
                self.tableView2.reloadData()
                self.noData()
                
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
    
    
    
}













