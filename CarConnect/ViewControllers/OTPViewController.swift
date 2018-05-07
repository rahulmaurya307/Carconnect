//
//  OTPViewController.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/3/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class OTPViewController: UIViewController,UITextFieldDelegate {
   
    
    var mobileNumber : String!
    var otp : Int!
   
    var otpId : Int!
   
    var flag : String!
    
    @IBOutlet var txtFieldEnterOTP : UITextField!

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFieldEnterOTP.delegate = self

        if (flag == "login"){
            generateOtp()
        }else if (flag == "fPPass"){
            print("In Otp View Controller OTP: \(otp)")
            print("In Otp View Controller OTP_ID: \(otpId)")
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        txtFieldEnterOTP.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ResendOtpBtn(_ sender: Any) {
       

        resendOtpAction()
        
        /*let ResendOtpBtn = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController
        self.present(ResendOtpBtn, animated: true, completion: nil)*/
        
        
    }
    
    @IBAction func btnVerifyOTP(_ sender: Any) {
     
        if (txtFieldEnterOTP.text?.isEmpty)!{
        
            self.view.makeToast("Please Enter OTP")
        }
        else{
         VerifyOTP()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func generateOtp(){
        self.view.makeToastActivity(.center)
        let parameters: [String: Any] = ["userMobile" : mobileNumber]
        
        //Alamofire Request
        Alamofire.request(WebUrl.GENERATE_OTP_URL, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            let message = json["message"].stringValue
            
            /*****************Response Success *****************/
            
            if (status == WebUrl.SUCCESS_CODE){
                var name : String!, email : String!, mobile : String!, userId : Int!, loyaltyId : String!

                let data = json["data"].array
                for i in data! {
                    
                    self.otpId = i["otpId"].intValue
                    self.view.makeToast(message)

                }
                
            }else{
                self.view.makeToast(message)
                }
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Server Error")
                
                
            }
        }
    }
    
    
    func VerifyOTP() {
        self.view.makeToastActivity(.center)
        let parameters: [String: Any] = ["userMobile" : mobileNumber, "otpId" : otpId,
                                         "otp" : txtFieldEnterOTP.text]
        
        //Alamofire Request
        Alamofire.request(WebUrl.VERIFY_OTP_URL, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            let message = json["message"].stringValue
            
/*****************Response Success *****************/
            
            if (status == WebUrl.SUCCESS_CODE){
  
                let enterPassVC = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController
                enterPassVC.mobileNumber = self.mobileNumber
                self.present(enterPassVC, animated: true, completion: nil)
                
                
            }else{
            
                self.view.makeToast(message)
                }
/***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Server Error")
                
                
            }
        }
        
        
        
    }
    
    
    func resendOtpAction(){
        self.view.makeToastActivity(.center)
        let parameters: [String: Any] = ["userMobile" : mobileNumber, "otpId" : otpId]
        
        //Alamofire Request
        Alamofire.request(WebUrl.RESEND_OTP_URL, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            let message = json["message"].stringValue
            
            /*****************Response Success *****************/
            
            if (status == WebUrl.SUCCESS_CODE){
                var name : String!, email : String!, mobile : String!, userId : Int!, loyaltyId : String!

                let data = json["data"].array
                for i in data! {
                    
                    self.otpId = i["otpId"].intValue
                    self.view.makeToast("OTP Sent Sucessfully on Your Number")

                }
                
            }else{
                self.view.makeToast(message)

                }
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Server Error")
                
                
            }
        }
    }

   
}
