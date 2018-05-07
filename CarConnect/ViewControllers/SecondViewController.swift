//
//  SecondViewController.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/3/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
class SecondViewController: UIViewController, ENSideMenuDelegate,UITextFieldDelegate {
    var mobileNumber : String!
    
    @IBOutlet weak var txtFldPassword: UITextField!
    var session : Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFldPassword.delegate = self
        self.sideMenuController()?.sideMenu?.delegate = self
        print(mobileNumber)
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnLogin(_ sender: Any) {
         textFieldShouldReturn(txtFldPassword)
        if(txtFldPassword.text?.isEmpty)!{
            //self.view.makeToast("Please Enter Password")
            let alert = UIAlertController(title: "Alert", message: "Please Enter Password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            loginAction()
        }
        
    }
    
    @IBAction func btnForgetPass(_ sender: Any) {
        forgotPassAction()
    }
    
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        print("sideMenuShouldOpenSideMenu")
        return true
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }

  
    
    
    func loginAction(){
        self.view.makeToastActivity(.center)
        //Set Parameters
        let parameters: [String: Any] = ["userName" : mobileNumber, "userPassword" : txtFldPassword.text]
        
        //Alamofire Request
        Alamofire.request(WebUrl.LOGIN_URL, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            let message = json["message"].stringValue
            
/*****************Response Success *****************/
            
            if (status == WebUrl.SUCCESS_CODE){
                self.view.hideToastActivity()
                var name : String!, email : String!, mobile : String!, userId : Int!, loyaltyId : String!, token : String!
                UserDefaults.standard.set(true, forKey: "session") //Bool

                
                let data = json["data"].array
                for i in data! {
                
                    name = i["name"].stringValue
                    email = i["email"].stringValue
                    mobile = i["mobile"].stringValue
                    userId = i["userId"].intValue
                    loyaltyId = i["loyaltyId"].stringValue
                    token = i["token"].stringValue
                    
                    UserDefaults.standard.set(token, forKey: "token") //setObject
                    UserDefaults.standard.set(userId, forKey: "userId") //setObject
                    UserDefaults.standard.set(mobile, forKey: "mobile") //setObject
                    UserDefaults.standard.set(loyaltyId, forKey: "loyaltyId") //setObject
                    UserDefaults.standard.set(email, forKey: "email") //setObject
                    UserDefaults.standard.set(name, forKey: "name")
                }
                AppDelegate.getDelegate().resetView()
            }else{
                //self.view.makeToast(message)
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                }
/***************** Network Error *****************/
            case .failure (let error):
                //self.view.makeToast("Network Error")
                let alert = UIAlertController(title: "Alert", message: "Network Error", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
    }
   
    
    func forgotPassAction(){
        self.view.makeToastActivity(.center)
        
//Set Parameters
        let parameters: [String: Any] = ["userMobile" : mobileNumber]
        
//Alamofire Request
        Alamofire.request(WebUrl.FORGOT_PASS_URL, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            let message = json["message"].stringValue
            
/*****************Response Success *****************/
            
            if (status == WebUrl.SUCCESS_CODE){
                
                let data = json["data"].array
                for i in data! {
                    
                    var otp : Int!,  otpId : Int!
                    
                    let data = json["data"].array
                    for i in data! {
                        
                        otp = i["otp"].intValue
                        otpId = i["otpId"].intValue
                        self.view.makeToast("OTP Sucessfully Send On Your Number")

                    }

        let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                    SecVC.otpId = otpId
                    SecVC.otp = otp
                    SecVC.flag = "fPPass"
                    SecVC.mobileNumber = self.mobileNumber
                    self.present(SecVC, animated: true, completion: nil)

                    
/***************** Set Login condition *****************
                    let textfieldpswdInt: Int?  = Int(self.txtFldPassword.text!)
                   // let textfieldInt: Int? = Int(textField1.text!)
                    if(otp == textfieldpswdInt){
                        self.view.makeToast("String Is Equal")
                    }
                    else{
                        self.view.makeToast(message)
                    }*/
        }
            }
            
                
/***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Server Error")
                
                
            }
        }
        
    }

}
