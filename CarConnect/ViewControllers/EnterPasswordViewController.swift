
import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift


class EnterPasswordViewController: UIViewController,UITextFieldDelegate {
    var mobileNumber : String!
    @IBOutlet weak var txtFldConfirmPass: UITextField!
    @IBOutlet weak var textFldEnterPass: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFldConfirmPass.delegate = self
        textFldEnterPass.delegate = self
        
      
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        txtFldConfirmPass.resignFirstResponder()
        textFldEnterPass.resignFirstResponder()
        return true
    }
    
    
    @IBAction func btnSubmit(_ sender: Any) {
        
        if(textFldEnterPass.text?.isEmpty)!{
           
            self.view.makeToast("Please Enter Password")
        }
        else if(txtFldConfirmPass.text?.isEmpty)!{
            
            self.view.makeToast("Please Enter Confirm Password")
        }
       else if(textFldEnterPass.text != txtFldConfirmPass.text){
           
            self.view.makeToast("Password or Confirm Password Does Not Match")
        }
        else {
          
            SubmitPassword()
        }
        
    }
    
    func SubmitPassword()
    {
        self.view.makeToastActivity(.center)
       
//Set Parameters
        
    let parameters: [String: Any] = ["userMobile" : mobileNumber,"password" :textFldEnterPass.text]
        
//Alamofire Request
        
        Alamofire.request(WebUrl.SET_PASSWORD_URL, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            switch response.result {
            case .success (let value):let json = JSON(value)
          
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            
/*****************Response Success *****************/
            
            if (status == WebUrl.SUCCESS_CODE){
           
                let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
                SecVC.mobileNumber = self.mobileNumber
                self.present(SecVC, animated: true, completion: nil)
               
                }
 
/***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Server Error")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
}

