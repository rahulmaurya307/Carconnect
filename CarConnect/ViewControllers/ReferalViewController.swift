import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift


protocol SuccessRefProtocol {
    func SuccessRefFunc(Success : String?)
}

class ReferalViewController: UIViewController, UITextFieldDelegate {
    
    
   // @IBOutlet weak var txtFldCmnt: UITextView!
    var referralTypeId : String!
    var delegate : SuccessRefProtocol?
    @IBOutlet weak var txtFldCmnt: UITextField!
    @IBOutlet weak var txtFldRefEmail: UITextField!
    @IBOutlet weak var txtFldMobNo: UITextField!
    @IBOutlet weak var txtFldRefName: UITextField!
    
    @IBOutlet weak var viewBorder: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        borderColor()
        txtFldCmnt.delegate = self
        txtFldRefEmail.delegate = self
        txtFldMobNo.delegate = self
        txtFldRefName.delegate = self
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        txtFldCmnt.resignFirstResponder()
        txtFldRefEmail.resignFirstResponder()
        txtFldMobNo.resignFirstResponder()
        txtFldRefName.resignFirstResponder()
        return true
    }
    
func borderColor(){
        
        self.viewBorder.layer.borderWidth = 1
        self.viewBorder.layer.borderColor = UIColor.black.cgColor
    }
    
    
    @IBAction func backBtn (_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
         var charachter : String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        if (txtFldRefName.text?.isEmpty)!{
            self.view.makeToast("Please Enter Referral Name")
        }
           else if ((txtFldMobNo.text?.count)! < 10)
         {
            self.view.makeToast("Please Enter 10 Digit Mobile Number")
        }
        else if ((txtFldMobNo.text?.count)! > 10)
        {
            self.view.makeToast("Please Enter 10 Digit Mobile Number")
        }
        else if (txtFldMobNo.text?.isEmpty)!
             {
                 self.view.makeToast("Please Enter Mobile Number")
        }
            else if (txtFldRefEmail.text?.isEmpty)!{
                self.view.makeToast("Please Enter Email")
        }
        else if (NSPredicate(format: "SELF MATCHES %@", charachter).evaluate(with: txtFldRefEmail.text) == false){
             self.view.makeToast("Please enter valid email")
        }
      
        else{
            addRefer()
        }
       
    }

    ///////////*****************Function Start to Get Total Points *****************///////////
    func addRefer(){
        self.view.makeToastActivity(.center)
        let loyaltyId : String = UserDefaults.standard.string(forKey: "loyaltyId")!
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let referralName = txtFldRefName.text
        let referralMobile = txtFldMobNo.text
        let referralEmail = txtFldRefEmail.text
        let comment = txtFldCmnt.text
        
        
// Parameters
        let parameters: [String: Any] = ["referralTypeId":referralTypeId,"referralName":referralName,"loyaltyId":loyaltyId,"referralMobile":referralMobile,"referralEmail":referralEmail,"comment":comment]
        
        
//Alamofire Request
        Alamofire.request(WebUrl.ADD_REFERRAL_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
//Response Success
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let alert = UIAlertController(title: "Alert", message: "Sucessfully Added", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        self.delegate?.SuccessRefFunc(Success: "true")
                        self.dismiss(animated: true, completion: nil)
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                        
                    }}))
                self.present(alert, animated: true, completion: nil)
              //self.view.makeToast("Sucessfully Added")
            }
//Network Error
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }
    /*****************Function End to Get Total Points *****************///////////

        
        
        
    }


