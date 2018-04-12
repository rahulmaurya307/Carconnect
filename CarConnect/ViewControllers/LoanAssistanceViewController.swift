//
//  LoanAssistanceViewController.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/25/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift
import SwiftyJSON
import AlamofireImage

class LoanAssistanceViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var btnSelfEmp: ISRadioButton!
    @IBOutlet var btnSalaried: ISRadioButton!
    
    @IBOutlet var txtFldCompanyName: UITextField!
    @IBOutlet var txtFldAnnualSalary: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFldCompanyName.delegate = self
        txtFldAnnualSalary.delegate = self
        
        self.sideMenuController()?.sideMenu?.delegate = MySideMenu()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        txtFldCompanyName.resignFirstResponder()
        txtFldAnnualSalary.resignFirstResponder()
       
        return true
    }
    
            var val = 0
            var jobTitle : String!
    
    @IBAction func btnSelfEmp(_ sender: Any) {
        btnSelfEmp.isSelected = true
        if btnSelfEmp.isSelected{
            btnSalaried.isSelected = false
            val = 1
            if val == 1 {
                jobTitle = "Self Employed"
                print("MyJobTitleSelfButton :\(jobTitle)")
            }
        }
    }
    @IBAction func btnSalaried(_ sender: Any) {
        btnSalaried.isSelected = true
        if btnSalaried.isSelected{
            btnSelfEmp.isSelected = false
            val = 2
            if (val == 2){
                jobTitle = "Salaried"
                print("MyJobTitleEmployeeButton :\(jobTitle)")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnRequestCallBack(_ sender: Any) {
       
        if val != 1 && val != 2 {
                self.view.makeToast("Plase Select Profession")
        }else if (txtFldCompanyName.text?.isEmpty)! {
            self.view.makeToast("Please Fill Company Name")
        }else if (txtFldAnnualSalary.text?.isEmpty)!{
            self.view.makeToast("Please fill Annual Salary")
        }else{
             requestCallBack()
        }
        
    }
    @IBAction func btnCalculateLoan(_ sender: Any) {
                let loanCalVC = self.storyboard?.instantiateViewController(withIdentifier: "LoanCalculateViewController") as! LoanCalculateViewController
        self.present(loanCalVC, animated: false, completion: nil)
    }
    
    @IBAction func HometoggleSideMenuBtn(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
    
    
    func requestCallBack()
    {
        
        let location : String = "Delhi"
        let name : String = UserDefaults.standard.string(forKey: "name")!
        let email : String = UserDefaults.standard.string(forKey: "email")!
        let contact : String = UserDefaults.standard.string(forKey: "mobile")!
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["location":location, "name":name,"email":email, "contact":contact, "profession":jobTitle, "companyName":txtFldCompanyName.text, "annualSalary":txtFldAnnualSalary.text]
        
        //Alamofire Request
        Alamofire.request(WebUrl.ADD_LOAN_ASSISTANCE_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            // print("NewCarJsonResponse: \(response.result)")
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                 print(data)
               // self.view.makeToast("Success")
                

                let alert = UIAlertController(title: "Sucessfully Send", message: "We have receive your request and will call you back soon", preferredStyle: UIAlertControllerStyle.alert)
                self.present(alert, animated: true, completion: nil)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("ok")
                        AppDelegate.getDelegate().resetView()
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                    }}))
                
                }
           
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
        
    }
}
