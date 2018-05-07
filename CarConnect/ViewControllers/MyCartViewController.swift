


import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift


class MyCartViewController: UIViewController, UITableViewDataSource, CartDelegate{
    
    @IBOutlet var noItemsView: UIView!
    func valueLable(update: String, cartId: String, quantity: String) {
        let loyltyId = UserDefaults.standard.string(forKey: "loyaltyId")!
        if(update == "delete"){
            deleteCart(cartId: cartId, loyltyId: loyltyId)
        }else if(update == "update"){
            updateCart(prductId: cartId, loyltyId: loyltyId, productQty: quantity)
        }
        print(update+"   "+cartId+"    "+quantity)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
   
    @IBOutlet var myTableView: UITableView!
    var myCartList : [MyCartModel] = [MyCartModel]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.backgroundView = noItemsView
        noItemsView.isHidden = true
        self.myTableView.rowHeight = 230.0
         getMyCartList()
    }
    
   
    func noData(){
        if myTableView.visibleCells.isEmpty{
            noItemsView.isHidden = false
        }else {
            noItemsView.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //getMyCartList()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    @IBAction func btnCheckOut(_ sender: Any) {
        if #available(iOS 10.0, *) {
            let MPVC = self.storyboard?.instantiateViewController(withIdentifier: "MakePaymentViewController") as! MakePaymentViewController
            MPVC.myCartList = myCartList
            
            self.present(MPVC, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
       
    }
    
func getMyCartList()
    {
    self.view.makeToastActivity(.center)
    let token : String = UserDefaults.standard.string(forKey: "token")!
    let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
    
    // Parameters
    let parameters: [String: Any] = ["loyaltyId":loyaltyId]
    
    //Alamofire Request
    Alamofire.request(WebUrl.CART_LIST_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
        //Response Success
        switch response.result {
        case .success (let value):let json = JSON(value)
        self.view.hideToastActivity()
        print("Track Referal JSON: \(json)")
        let status = json["status"].stringValue
        if (status == WebUrl.SUCCESS_CODE){
             UserDefaults.standard.set(String(describing: json), forKey: "cartData") //setObject
            let data = json["data"].array
            for i in data! {
                let myTrackRefList = JSON(i)
                let productList = myTrackRefList["productList"].array
                
                for dataModel in productList! {
                    let cartId = dataModel["cartId"].stringValue
                    let productId = dataModel["productId"].stringValue
                    let quantity = dataModel["quantity"].stringValue
                    let productName = dataModel["productName"].stringValue
                    let productState = dataModel["productState"].stringValue
                    let productImage = dataModel["productImage"].stringValue
                    let price = dataModel["price"].stringValue
                    let inventory = dataModel["inventory"].stringValue
                    let productSold = dataModel["productSold"].stringValue
                    
                    var myInventory : Int?  = Int(inventory)
                    var myProductSold : Int? = Int(productSold)
                    
                    
                    if(myProductSold == nil){
                        myProductSold = 0
                    }else if(myInventory == nil){
                        myInventory = 0
                    }
                    
                    var itemLeft = myInventory! - myProductSold!
                    let myImage = WebUrl.PRODUCT_IMAGE_URL + productImage
                    self.myCartList.append(MyCartModel(cartId: cartId, productId: productId, quantity: quantity, productName: productName, productState: productState, productImage: myImage, price: price, inventory: inventory, productSold: productSold, itemLeft: itemLeft))
                }
            }
            self.myTableView.reloadData()
             self.noData()
        }
            
        //Network Error
        case .failure (let error):
            self.view.makeToast("Network Error")
        }
     }
}
    
    func updateCart(prductId : String!, loyltyId : String!, productQty : String!){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyaltyId, "quantity":productQty, "productId":prductId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.UPDATE_CART_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("Track Referal JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                self.myCartList.removeAll()
                self.getMyCartList()
                self.view.makeToast("Sucessfully Updated")
                
                }
                
            //Network Error
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }
    
    func  deleteCart(cartId : String, loyltyId : String){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyltyId, "cartId":cartId ]
        
        //Alamofire Request
        Alamofire.request(WebUrl.DELETE_CART_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("Track Referal JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                self.myCartList.removeAll()
                self.getMyCartList()
                
                }
                
            //Network Error
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }
  
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            print("Deleted")
            self.myCartList.remove(at: indexPath.row)
            self.myTableView.deleteRows(at: [indexPath], with: .automatic)
            print("Helloooooo: \(indexPath)")
    }
}
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCartList.count
    }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let MyCartCell  = Bundle.main.loadNibNamed("MyCartCell", owner: self, options: nil)?.first as! MyCartCell
    
    
        let url = URL(string: myCartList[indexPath.row].productImage)!
        MyCartCell.imgCart.af_setImage(withURL: url)
    
        MyCartCell.itemLeft = myCartList[indexPath.row].itemLeft
        MyCartCell.txtvwCart.text = myCartList[indexPath.row].productName
        MyCartCell.lblPrice.text = "₹ " + myCartList[indexPath.row].price
        MyCartCell.lblProductQuantity.text = myCartList[indexPath.row].quantity
        MyCartCell.lblId.text = myCartList[indexPath.row].cartId
        MyCartCell.productID.text = myCartList[indexPath.row].productId
        MyCartCell.delegate = self
        return MyCartCell
        
    }
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }

}





    

