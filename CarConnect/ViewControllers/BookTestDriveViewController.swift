
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift

class BookTestDriveViewController: UIViewController {
    var carId : String!
    var myDateTime : String!
    var finalDate : String!
    var finalTime : String!
    @IBOutlet var txtFldName: UITextField!
    @IBOutlet var txtFldMobNo: UITextField!
    @IBOutlet var txtFldDate: UITextField!
    var datePicker : UIDatePicker = UIDatePicker()
    @IBOutlet var txtFldEmail: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFldName.text = UserDefaults.standard.string(forKey: "name")
        txtFldEmail.text = UserDefaults.standard.string(forKey: "email")
        txtFldMobNo.text = UserDefaults.standard.string(forKey: "mobile")
        
    }
    
func pickUpDate(_ textField : UITextField){
        
// DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        datePicker.timeZone = NSTimeZone.local
        self.datePicker.backgroundColor = UIColor.white
        textField.inputView = self.datePicker
    

// ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
    
    
// Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BookTestDriveViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(BookTestDriveViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
func doneClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        txtFldDate.text = dateFormatter.string(from: datePicker.date)
        txtFldDate.resignFirstResponder()
    
     myDateTime  = txtFldDate.text
     var splitStringinArray = myDateTime.components(separatedBy: " ")
     finalDate = splitStringinArray[0]
     finalTime = splitStringinArray[1]
    
    }
    
    
func cancelClick() {
        txtFldDate.resignFirstResponder()
    }
    
func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUpDate(self.txtFldDate)
    }
  
    @IBAction func btnSubmit(_ sender: Any) {
        
        if (self.txtFldDate.text?.isEmpty)!{
            self.view.makeToast("Please Select Date or Time")

        }
        else{
            submitTestDriveDetails ()
            print("Book Your Test Drive")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backBtn (_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
func submitTestDriveDetails (){
      print("Book Your Test Drive Function")
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["modelId" : carId,"custName" : txtFldName.text,"custEmail" : txtFldEmail.text,"custContact" : txtFldMobNo.text,"bookdate" : finalDate,"booktime" : finalTime,]
        
        //Alamofire Request
        Alamofire.request(WebUrl.BOOK_TEST_DRIVE_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            // print("NewCarJsonResponse: \(response.result)")
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                 self.view.makeToast("Your Drive Has Been Saved ")
                }
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
}
