
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift

class BookTestDriveViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
    var carId : String!
    var myDateTime : String!
    var finalDate : String!
    var finalTime : String!
    @IBOutlet var txtFldName: UITextField!
    @IBOutlet var txtFldMobNo: UITextField!
    @IBOutlet var txtFldDate: UITextField!
    var datePicker : UIDatePicker = UIDatePicker()
    @IBOutlet var txtFldEmail: UITextField!
    @IBOutlet var txtFldLoc: UITextField!
    var cityPicker = UIPickerView ()
    var selectCity = [String?]()
    var selectState = [String?]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFldName.text = UserDefaults.standard.string(forKey: "name")
        txtFldEmail.text = UserDefaults.standard.string(forKey: "email")
        txtFldMobNo.text = UserDefaults.standard.string(forKey: "mobile")
        
        cityPicker.delegate = self
        cityPicker.dataSource = self
        txtFldLoc.inputView = cityPicker
        
        getLocationList()
        
    }
    
    
    public func numberOfComponents(in pickerView:  UIPickerView) -> Int  {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return selectCity.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return selectCity[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtFldLoc.text = selectCity[row]
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
        toolBar.tintColor = UIColor.darkGray
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
        self.dismiss(animated: true, completion: nil)
    }
    
func submitTestDriveDetails (){
    self.view.makeToastActivity(.center)
      print("Book Your Test Drive Function")
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["modelId" : carId,"custName" : txtFldName.text,"custEmail" : txtFldEmail.text,"custContact" : txtFldMobNo.text,"bookdate" : finalDate,"booktime" : finalTime,"location" : txtFldLoc.text]
        
        //Alamofire Request
        Alamofire.request(WebUrl.BOOK_TEST_DRIVE_URL+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            // print("NewCarJsonResponse: \(response.result)")
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                 self.view.makeToast("Your Drive Has Been Saved ")
                }
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }

    func getLocationList(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["":""]
        
        //Alamofire Request
        Alamofire.request(WebUrl.LOCATION+"?token="+token, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            // print("NewCarJsonResponse: \(response.result)")
            
            /*****************Response Success *****************/
            switch response.result {
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    //let newCarList = i["newcarList"] as JSON // Read Json Object
                    let locationList = i["locationList"].array
                    
                    for dataModel in locationList! {      // Parse Json Array
                        let city = dataModel["city"].stringValue
                        let state = dataModel["state"].stringValue
                        let dealerName = dataModel["dealerName"].stringValue
                        print("city : \(city)")
                        print("state : \(state)")
                        print("dealerName : \(dealerName)")
                        
                        self.selectCity.append(city)
                        self.selectState.append(state)
                        
//                        self.locationList.append(LocationModel(dealerName: dealerName, city: city, state: state))
                    }
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
