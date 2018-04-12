

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift
import GooglePlaces

class MyCarsDetailViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,
UINavigationControllerDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate{
    
    var datePicker : UIDatePicker = UIDatePicker()
    var brandName : String!
    var modelName : String!
    var varientNAme : String!
    var image1 : String!
    var carId : String!
    var imagePicker = UIImagePickerController()
    var val = 0
    var selectedImages : UIImage!
   
    
    var servicePickerType : Bool!
    var colorPickerType : Bool!
    var ownerPickerType : Bool!
    var carOwnerList = ["First", "Second", "Third", "Forth"]
    

    
@IBOutlet var SegmentCarDetail: UISegmentedControl!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    
    
// Book Services View
    @IBOutlet var ViewBookService: UIView!
    @IBOutlet var viewServiceTextView: UIView!
    @IBOutlet var viewSelectCityTextView: UIView!
    @IBOutlet weak var txtFldServiceType: UITextField!
    @IBOutlet var textvwSelectCity: UITextField!
    
    

// Insurance View
    @IBOutlet var viewInsuranceRenew: UIView!
    @IBOutlet var ViewCity: UIView!
    @IBOutlet var ViewExpiry: UIView!
    @IBOutlet var btnView: UIView!
    @IBOutlet var txtfldSelectCity: UITextField!
    @IBOutlet var txtfldExpiryDate: UITextField!
    
    
// Sell Your car View
    @IBOutlet var viewSellYourCar: UIView!
    @IBOutlet var imgvwCam1: UIImageView!
    @IBOutlet var imagevwCam2: UIImageView!
    @IBOutlet var imagevwCam3: UIImageView!
    @IBOutlet var txtFldKmsDrive: UITextField!
    @IBOutlet var txtFldState: UITextField!
    @IBOutlet var txtFldExpectedPrice: UITextField!
    @IBOutlet var txtFldColor: UITextField!
    @IBOutlet var txtFldOwner: UITextField!
    @IBOutlet var txtvwSellerComment: UITextView!
    var colorList : [ColorModel] = [ColorModel]()
    var colorArray = [String]()

    //Array declare
    var pickerArray = [String]()
    var i : Int  = 0
    var selectedRow = 0;
//Picker View Object
    let pickerServiceType = UIPickerView()
    let pickerColor = UIPickerView()
    let pickerOwner = UIPickerView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFldServiceType.delegate = self
        textvwSelectCity.delegate = self
        txtfldSelectCity.delegate = self
        txtfldExpiryDate.delegate = self
        txtFldKmsDrive.delegate = self
        txtFldState.delegate = self
        txtFldExpectedPrice.delegate = self
        txtFldColor.delegate = self
        txtFldOwner.delegate = self
        
        ServiceData()
        colorListAction()
        
        imagePicker.delegate = self
        
        viewServiceTextView.layer.borderWidth = 1
        viewServiceTextView.layer.borderColor = UIColor.darkGray.cgColor
        viewServiceTextView.layer.cornerRadius = 4
        
        viewSelectCityTextView.layer.borderWidth = 1
        viewSelectCityTextView.layer.borderColor = UIColor.darkGray.cgColor
        viewSelectCityTextView.layer.cornerRadius = 4
        
        ViewCity.layer.borderWidth = 1
        ViewCity.layer.borderColor = UIColor.darkGray.cgColor
        ViewCity.layer.cornerRadius = 4
        
        ViewExpiry.layer.borderWidth = 1
        ViewExpiry.layer.borderColor = UIColor.darkGray.cgColor
        ViewExpiry.layer.cornerRadius = 4
        
        ViewBookService.isHidden = false
        viewInsuranceRenew.isHidden = true
        viewSellYourCar.isHidden = true
        
            pickerServiceType.delegate = self
            pickerServiceType.dataSource = self
            pickerColor.delegate = self
            pickerColor.dataSource = self
            pickerOwner.delegate = self
            pickerOwner.dataSource = self
       
        doneButton()
      
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        txtFldServiceType.resignFirstResponder()
        textvwSelectCity.resignFirstResponder()
        txtfldSelectCity.resignFirstResponder()
        txtfldExpiryDate.resignFirstResponder()
        txtFldKmsDrive.resignFirstResponder()
        txtFldState.resignFirstResponder()
        txtFldExpectedPrice.resignFirstResponder()
        txtFldColor.resignFirstResponder()
        txtFldOwner.resignFirstResponder()
        txtvwSellerComment.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUpDate(txtfldExpiryDate)
        if textField == txtFldColor {
            val = 1
             doneButton()
             print("1 Val = \(val)")
           
        }else if textField == txtFldOwner {
            val = 2
            doneButton()
             print("2 Val = \(val)")
            
        }else if textField == txtFldServiceType {
            val = 3
             doneButton()
            print("0 Val = \(val)")
        }
    }
    
    @IBAction func txtFldColor(_ sender: Any) {
       
    }
    @IBAction func btnSubmit(_ sender: Any) {
        bookServiceAction()
    }
@IBAction func btnGetQuote(_ sender: Any) {
        insuranceAction()
    }
@IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func SegmentCarDetail(_ sender: Any) {
        switch (SegmentCarDetail.selectedSegmentIndex) {
        case 0:
            ViewBookService.isHidden = false
            viewInsuranceRenew.isHidden = true
            viewSellYourCar.isHidden = true
            break
        case 1:
            ViewBookService.isHidden = true
            viewInsuranceRenew.isHidden = false
            viewSellYourCar.isHidden = true
            break
        case 2:
            ViewBookService.isHidden = true
            viewInsuranceRenew.isHidden = true
            viewSellYourCar.isHidden = false
            break
        default:
            break
        }
        
    }
    
  
    
    @IBAction func btnCam1(_ sender: Any) {
        openCamSheet()
        i = 1
    }
    
    @IBAction func btnCam2(_ sender: Any) {
        openCamSheet()
        i = 2
    }
    
    @IBAction func btnCam3(_ sender: Any) {
        openCamSheet()
        i = 3
    }
    @IBAction func btnSubmitSellCar(_ sender: Any) {
        uploadImagesAndData()
    }
    
/************************** Date Picker Start **************************/
    
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
        toolBar.tintColor = UIColor(red: 63/255, green: 51/255, blue: 107/255, alpha: 1)
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
        //dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd"
        txtfldExpiryDate.text = dateFormatter.string(from: datePicker.date)
        txtfldExpiryDate.resignFirstResponder()
        
    }
    
    func cancelClick() {
        txtfldExpiryDate.resignFirstResponder()
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.pickUpDate(txtfldExpiryDate)
//    }
    
/************************** Date Picker End **************************/
    
    
public func numberOfComponents(in pickerView:  UIPickerView) -> Int  {
         return 1
}
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (val == 3){
          return pickerArray.count
        }else if (val == 1){
           return colorArray.count
        }else if (val == 2){
            return carOwnerList.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (val == 3){
              return pickerArray[row]
            }else if (val == 1){
             return colorArray[row]
        }else if (val == 2){
            return carOwnerList[row]
        }
        return "nil"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (val == 3){
            txtFldServiceType.text = pickerArray[row]
        }else if (val == 1){
            txtFldColor.text = colorArray[row]
        }else if (val == 2){
            txtFldOwner.text = carOwnerList[row]
        }
    }
    
func doneButton(){
    
    if (val == 3){
        let pickerView1 = pickerServiceType
        pickerView1.backgroundColor = .white
        pickerView1.showsSelectionIndicator = true
        
        var toolBar1 = UIToolbar()
        toolBar1.barStyle = UIBarStyle.default
        toolBar1.isTranslucent = true
        toolBar1.tintColor = UIColor(red: 63/255, green: 51/255, blue: 107/255, alpha: 1)
        toolBar1.sizeToFit()
        
        let doneButton1 = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: "donePicker1")
        let spaceButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton1 = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: "canclePicke1")
        
        toolBar1.setItems([cancelButton1, spaceButton1, doneButton1], animated: false)
        toolBar1.isUserInteractionEnabled = true
        
        txtFldServiceType.inputView = pickerServiceType
        txtFldServiceType.inputAccessoryView = toolBar1
        
    }else if (val == 1){
        let pickerView2 = pickerColor
        pickerView2.backgroundColor = .white
        pickerView2.showsSelectionIndicator = true
        
        var toolBar2 = UIToolbar()
        toolBar2.barStyle = UIBarStyle.default
        toolBar2.isTranslucent = true
        toolBar2.tintColor = UIColor(red: 63/255, green: 51/255, blue: 107/255, alpha: 1)
        toolBar2.sizeToFit()
        
        let doneButton2 = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: "donePicker2")
        let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton2 = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: "canclePicke2")
        
        toolBar2.setItems([cancelButton2, spaceButton2, doneButton2], animated: false)
        toolBar2.isUserInteractionEnabled = true
        
        txtFldColor.inputView = pickerColor
        txtFldColor.inputAccessoryView = toolBar2
        
    }else if (val == 2){
        let pickerView3 = pickerOwner
        pickerView3.backgroundColor = .white
        pickerView3.showsSelectionIndicator = true
        
        var toolBar3 = UIToolbar()
        toolBar3.barStyle = UIBarStyle.default
        toolBar3.isTranslucent = true
        toolBar3.tintColor = UIColor(red: 63/255, green: 51/255, blue: 107/255, alpha: 1)
        toolBar3.sizeToFit()
        
        let doneButton3 = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: "donePicker3")
        let spaceButton3 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton3 = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: "canclePicke3")
        
        toolBar3.setItems([cancelButton3, spaceButton3, doneButton3], animated: false)
        toolBar3.isUserInteractionEnabled = true
        
        txtFldOwner.inputView = pickerOwner
        txtFldOwner.inputAccessoryView = toolBar3
    }
    
}
            func donePicker1() {
                txtFldServiceType.resignFirstResponder()
            }
            func donePicker2() {
                txtFldColor.resignFirstResponder()
            }
            func donePicker3() {
                txtFldOwner.resignFirstResponder()
            }
    
    func canclePicke1() {
        txtFldServiceType.resignFirstResponder()
    }
    func canclePicke2() {
        txtFldColor.resignFirstResponder()
    }
    func canclePicke3() {
        txtFldOwner.resignFirstResponder()
    }

    func ServiceData(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["token":token]
        
        //Alamofire Request
        Alamofire.request(WebUrl.SERVICE_LIST_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            print("NewCarJsonResponse: \(response)")
            
            /*****************Response Success *****************/
            switch response.result {
                
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                
                for i in data! {
                    let myCarList = JSON(i)// Read Json Object
                    let serviceList = myCarList["serviceList"].array   // Read Json Array
                    
                    for dataModel in serviceList! {      // Parse Json Array
                        let serviceName = dataModel["serviceName"].stringValue
                     
                        self.pickerArray.append(serviceName)
                        
                    }
                   
                }
        }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
    
    
/************** Book Service **********************/
    func bookServiceAction(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["serviceType":txtFldServiceType.text!, "location":textvwSelectCity.text!]
        
        //Alamofire Request
        Alamofire.request(WebUrl.BOOK_SERVICE_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            print("NewCarJsonResponse: \(response)")
            
            /*****************Response Success *****************/
            switch response.result {
                
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                self.view.makeToast("Request Successfully Submited")
               
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
    
    /*************** Insurance Action ********************/
    func insuranceAction(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["location":txtfldSelectCity.text!, "modelName":modelName!,"brandName":brandName!, "varientName":varientNAme!,"purchaseDate":txtfldExpiryDate.text!]
        
        print(parameters)
        
        //Alamofire Request
        Alamofire.request(WebUrl.INSURANCE_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            print("NewCarJsonResponse: \(response)")
            
            /*****************Response Success *****************/
            switch response.result {
                
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                self.view.makeToast("Request Successfully Submited")
                
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
    
    
    
    /*************** Insurance Action ********************/
    func colorListAction(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["token":token]
        
        print(parameters)
        
        //Alamofire Request
        Alamofire.request(WebUrl.COLOR_LIST_URL, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            print("NewCarJsonResponse: \(response)")
            
            /*****************Response Success *****************/
            switch response.result {
                
            case .success (let value):let json = JSON(value)
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                let data = json["data"].array
                for i in data! {
                    let myCarList = JSON(i)// Read Json Object
                    let colorList = myCarList["colorList"] as JSON   // Read Json Array
                
                    let colorList1 = colorList["data"].array
                    for dataModel in colorList1! {
                        var id = dataModel["id"].stringValue
                        var colorName = dataModel["colorName"].stringValue
                        var colorCode = dataModel["colorCode"].stringValue
                        
                        self.colorArray.append(colorName)
                        
                        self.colorList.append(ColorModel(id: id, colorName: colorName, colorCode: colorCode))
                    }
                }
        }
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.makeToast("Network Error")
            }
        }
    }
    
    
    func uploadImagesAndData(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let imageData1  = UIImageJPEGRepresentation(imgvwCam1.image!, 0.5)
        let imageData2  = UIImageJPEGRepresentation(selectedImages!, 0.5)
        let imageData3  = UIImageJPEGRepresentation(selectedImages!, 0.5)
        
        let params: [String: Any] = ["carId": carId, "kmsdriven":txtFldKmsDrive.text!, "state":txtFldState.text!, "price":txtFldExpectedPrice.text!,
                                     "color":txtFldColor.text!, "owner":txtFldOwner.text!, "comment":txtvwSellerComment.text!]
        
        print(params)
        
        Alamofire.upload(multipartFormData: { multipartFormData in
           
            multipartFormData.append(imageData1!, withName: "vehicleImages[0]", mimeType: "image/jpeg")
//            multipartFormData.append(imageData2, withName: "vehicleImages[1]", mimeType: "image/jpeg")
//            multipartFormData.append(imageData3, withName: "vehicleImages[2]", mimeType: "image/jpeg")
            
            for (key, value) in params {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                    print(key)
                    
                }
               
            }
            
        },
        to: WebUrl.CLASSIFIED_LIST_URL+"?token="+token, encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload
                                    .validate()
                                    .responseJSON { response in
                                        switch response.result {
                                        case .success(let value):
                                            let json = JSON(value)
                                            print("responseObject: \(json)")
                                        case .failure(let responseError):
                                            print("responseError: \(responseError)")
                                        }
                                }
                            case .failure(let encodingError):
                                print("encodingError: \(encodingError)")
                            }
        })
    }
    
    func sendData(){
    }
    
    func openCamSheet(){ 
        print("Action Sheet")
        let alertController = UIAlertController(title: "Select Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        
        let somethingAction = UIAlertAction(title: "Camera", style: .default, handler: {(alert: UIAlertAction!) in print("Camera")
            self.openCamera()
        })
        
        let somethingAction2 = UIAlertAction(title: "Gallery", style: .default, handler: {(alert: UIAlertAction!) in
            self.openGallery()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        
        alertController.addAction(somethingAction)
        alertController.addAction(somethingAction2)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:{})
        }
    }
    
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage //1
        if(i == 1){
            imgvwCam1.contentMode = .scaleAspectFit
            imgvwCam1.image = chosenImage
            selectedImages = chosenImage
        }else if(i == 2){
            imagevwCam2.contentMode = .scaleAspectFit
            imagevwCam2.image = chosenImage
            selectedImages = chosenImage
        }else if(i == 3){
            imagevwCam3.contentMode = .scaleAspectFit
            imagevwCam3.image = chosenImage
            selectedImages = chosenImage
        }
        dismiss(animated:true, completion: nil)
    }
}



