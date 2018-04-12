//
//  ViewController.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/3/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift


class ViewController: UIViewController,UITextFieldDelegate {
    var selectedName: String = "Anonymous"
    
    
    @IBOutlet weak var txtFldMobileNo: UITextField!
    
    /*Login Button Action*/
    @IBAction func loginBtn(_sender: UIButton) {
        if(txtFldMobileNo.text?.isEmpty)!{
            //self.view.makeToast("Please Enter Mobile Number")
            
            let alert = UIAlertController(title: "Alert", message: "Please Enter Mobile Number", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else if((txtFldMobileNo.text?.count)!  < 10){
            //self.view.makeToast("Please Enter Correct Mobile Number")
            let alert = UIAlertController(title: "Alert", message: "Please Enter Correct Mobile Number", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            
            self.loginAction()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        txtFldMobileNo.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        hideKeyboard()
        txtFldMobileNo.delegate = self
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = MySideMenu()
        
        UserDefaults.standard.bool(forKey: "session")
        if UserDefaults.standard.bool(forKey: "session") {
            AppDelegate.getDelegate().resetView()
            
        }
        
        print ("mobileeeeee : \(UserDefaults.standard.bool(forKey: "mobile"))")
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        txtFldMobileNo.resignFirstResponder()
        return true
    }
    
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    
    
    /*****************Login Method *****************/
    
    func loginAction(){
        self.view.makeToastActivity(.center)
        //Set Parameters
        let parameters: [String: Any] = ["userMobile" : txtFldMobileNo.text]
        
        //Alamofire Request
        Alamofire.request(WebUrl.REGSTATUS, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            
            /*****************Response Success *****************/
            
            if (status == WebUrl.SUCCESS_CODE){
                var loyUser : String!, fLLogin : String!
                
                
                
                let data = json["data"].array
                for i in data! {
                    print(i["loyaltyUser"])
                    print(i["firstTimeLogin"])
                    
                    loyUser = i["loyaltyUser"].stringValue
                    fLLogin = i["firstTimeLogin"].stringValue
                }
                
                /***************** Set Login condition *****************/
                
                if(loyUser == "false"){
                    //self.view.makeToast("Invalid Credential.")
                    let alert = UIAlertController(title: "Alert", message: "Sorry You do not have required access ", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else if (loyUser == "true" && fLLogin == "true"){
                    let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                    SecVC.mobileNumber = self.txtFldMobileNo.text
                    SecVC.flag = "login"
                    self.present(SecVC, animated: true, completion: nil)
                }else if(loyUser == "true" && fLLogin == "false"){
                    let SecVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
                    SecVC.mobileNumber = self.txtFldMobileNo.text
                    self.present(SecVC, animated: true, completion: nil)
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

