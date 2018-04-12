
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift

class VoucherViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,VoucherClicked {
    
    var selectVoucherList = [String]()
     var delegate : VoucherDelegate?
   
    
    func vaucherClickedfunc(update: String, voucherID: String) {
        
        if(update == "ON"){
          selectVoucherList.append(voucherID)
        }else if(update == "OFF"){
            if let index = selectVoucherList.index(of: voucherID) {
                selectVoucherList.remove(at: index)
            }
        }
        for i in 0..<selectVoucherList.count{
         print(selectVoucherList)
        }
        
    }
    
    var voucherList : [VoucherModel] = [VoucherModel]()
    @IBOutlet var myTablview: UITableView!
    
   
   
    @IBAction func btnApplyVoucher(_ sender: Any) {
        delegate?.vaucherList(selectVoucherList: selectVoucherList)
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getVoucherName()
    
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voucherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = Bundle.main.loadNibNamed("VoucherNameCell", owner: self, options: nil)?.first as! VoucherNameCell
        cell2.lblVoucherName.text = voucherList[indexPath.row].voucherName
        cell2.VoucherID.text = voucherList[indexPath.row].id
        cell2.delegate = self
        return cell2
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70;//Choose your custom row height
    }
    
func getVoucherName() {
    self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        
        // Parameters
        let parameters: [String: Any] = ["loyaltyId":loyaltyId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.VOUCHER_LIST_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            //Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let myVoucherList = JSON(i)
                    let voucherList = myVoucherList["voucherList"].array
                    for dataModel in voucherList! {
                        let updated_at = dataModel["updated_at"].stringValue
                        let voucherDescription = dataModel["voucherDescription"].stringValue
                        let associateName = dataModel["associateName"].stringValue
                        let voucherStatus = dataModel["voucherStatus"].stringValue
                        let tierId = dataModel["tierId"].stringValue
                        let updatedBy = dataModel["updatedBy"].stringValue
                        let updatedType = dataModel["updatedType"].stringValue
                        let id = dataModel["id"].stringValue
                        let voucherTypeId = dataModel["voucherTypeId"].stringValue
                        let created_at = dataModel["created_at"].stringValue
                        let associateId = dataModel["associateId"].stringValue
                        let voucherState = dataModel["voucherState"].stringValue
                        let voucherName = dataModel["voucherName"].stringValue
                        
                        self.voucherList.append(VoucherModel(updated_at: updated_at, voucherDescription: voucherDescription, associateName: associateName, voucherStatus: voucherStatus, tierId: tierId, updatedBy: updatedBy, updatedType: updatedType, id: id, voucherTypeId: voucherTypeId, created_at: created_at, associateId: associateId, voucherState: voucherState, voucherName: voucherName))
                        
                    }
                    self.myTablview.reloadData()
                }
          }
                
            //Network Error
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }


}

protocol VoucherDelegate {
    func vaucherList(selectVoucherList : [String])
}


