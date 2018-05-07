

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Toast_Swift


class MyCarsDetailViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,
UINavigationControllerDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate{
    
    var datePicker : UIDatePicker = UIDatePicker()
    var locationList : [LocationModel] = [LocationModel]()
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
    var selectCity = [String?]()
    var selectState = [String?]()
    

    @IBOutlet var btnViewSubmt: UIView!
    
@IBOutlet var SegmentCarDetail: UISegmentedControl!
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
    @IBOutlet var txtvwSellerComment:UITextView!
    @IBOutlet var viewselcomment: UIView!
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
    let cityBook = UIPickerView()
    let cityInsurance = UIPickerView()
    let citySell = UIPickerView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("varientNAme :\(varientNAme)")
        
        btnViewSubmt.layer.cornerRadius = 3
        viewselcomment.layer.borderWidth = 0.5
        //viewselcomment.layer.borderColor =
        viewselcomment.layer.cornerRadius = 2
        
        imgvwCam1.makeCircular()
        imgvwCam1.layer.borderWidth = 1
        imagevwCam2.makeCircular()
        imagevwCam2.layer.borderWidth = 1
        imagevwCam3.makeCircular()
        imagevwCam3.layer.borderWidth = 1
        
        getLocationList()
        
        txtFldServiceType.delegate = self
        textvwSelectCity.delegate = self
        txtfldSelectCity.delegate = self
        txtfldExpiryDate.delegate = self
        txtFldKmsDrive.delegate = self
        txtFldState.delegate = self
        txtFldExpectedPrice.delegate = self
        txtFldColor.delegate = self
        txtFldOwner.delegate = self
        txtfldSelectCity.delegate = self
        
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
        
            cityBook.delegate = self
            cityBook.dataSource = self
        
            cityInsurance.delegate = self
            cityInsurance.dataSource = self
        
            textvwSelectCity.inputView = pickerOwner
            txtfldSelectCity.inputView = pickerOwner
            txtFldState.inputView = pickerOwner
       
        doneButton()
      
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        txtfldSelectCity.resignFirstResponder()
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
        }else if textField == textvwSelectCity {
            val = 4
            print("4 Val = \(val)")
        }else if textField == txtfldSelectCity {
            val = 5
            print("5 Val = \(val)")
        }else if textField == txtFldState {
            val = 6
            print("6 Val = \(val)")
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
        if ((txtvwSellerComment.text?.count)! < 50){
        let alert = UIAlertController(title: "Alert", message: "Comment Should be 50 Words", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{//uploadImagesAndData()
            uploadProfData()}
        
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
        }else if (val == 4){
            return selectCity.count
        }else if (val == 5){
            return selectCity.count
        }else if (val == 6){
            return selectState.count
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
        }else if (val == 4){
            return selectCity[row]
        }else if (val == 5){
            return selectCity[row]
        }else if (val == 6){
            return selectState[row]
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
        else if (val == 4){
            textvwSelectCity.text = selectCity[row]
        }
        else if (val == 5){
            txtfldSelectCity.text = selectCity[row]
        }
        else if (val == 6){
            txtFldState.text = selectState[row]
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
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["token":token]
        
        //Alamofire Request
        Alamofire.request(WebUrl.SERVICE_LIST_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            print("NewCarJsonResponse: \(response)")
            
            /*****************Response Success *****************/
            switch response.result {
                
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
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
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }
    
    
/************** Book Service **********************/
    func bookServiceAction(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        // Parameters
        let parameters: [String: Any] = ["serviceType":txtFldServiceType.text!, "location":textvwSelectCity.text!]
        
        //Alamofire Request
        Alamofire.request(WebUrl.BOOK_SERVICE_URL+"?token="+UserDefaults.standard.string(forKey: "token")!, method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            print("NewCarJsonResponse: \(response)")
            
            /*****************Response Success *****************/
            switch response.result {
                
            case .success (let value):let json = JSON(value)
            self.view.hideToastActivity()
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
        self.view.makeToastActivity(.center)
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
            self.view.hideToastActivity()
            print("JSON: \(json)")
            let status = json["status"].stringValue
            if (status == WebUrl.SUCCESS_CODE){
                self.view.makeToast("Request Successfully Submited")
                
                }
                
                /***************** Network Error *****************/
            case .failure (let error):
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
    }
    
    
    
    /*************** Insurance Action ********************/
    func colorListAction(){
        self.view.makeToastActivity(.center)
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
            self.view.hideToastActivity()
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
                self.view.hideToastActivity()
                self.view.makeToast("Network Error")
            }
        }
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
            //imgvwCam1.contentMode = .scaleAspectFit
            imgvwCam1.image = chosenImage
            selectedImages = chosenImage
        }else if(i == 2){
           // imagevwCam3.contentMode = .scaleAspectFit
            imagevwCam3.image = chosenImage
            selectedImages = chosenImage
        }else if(i == 3){
            //imagevwCam2.contentMode = .scaleAspectFit
            imagevwCam2.image = chosenImage
            selectedImages = chosenImage
        }
        dismiss(animated:true, completion: nil)
    }
    

    /************************** Upload Image Start **************************/
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    func uploadProfData(){
        let token : String = UserDefaults.standard.string(forKey: "token")!
        
        let image0 : UIImage
        image0 = resizeImage(image: imgvwCam1.image!, targetSize: CGSize(width: 400, height: 400))
        let imgData0 = UIImageJPEGRepresentation(image0, 0.2)!
        print("MyImage: \(image0.size)")
        
        let image1 : UIImage
        image1 = resizeImage(image: imagevwCam3.image!, targetSize: CGSize(width: 400, height: 400))
        let imgData1 = UIImageJPEGRepresentation(image1, 0.2)!
        print("MyImage: \(image1.size)")
        
        let image2 : UIImage
        image2 = resizeImage(image: imagevwCam2.image!, targetSize: CGSize(width: 400, height: 400))
        let imgData2 = UIImageJPEGRepresentation(image2, 0.2)!
        print("MyImage: \(image2.size)")
        
        let imagesData  = [imgData0,imgData1,imgData2]
        //let imageParamName : [String?] =  ["images[0]","images[1]","images[2]"]
        
        let parameters : [String:Any]  = ["carId": carId, "kmsdriven":txtFldKmsDrive.text!, "state":txtFldState.text!, "price":txtFldExpectedPrice.text!,
                                          "color":txtFldColor.text!, "owner":txtFldOwner.text!, "comment":txtvwSellerComment.text!]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            // import image to request
            for imageData in imagesData {
                multipartFormData.append(imageData, withName: "vehicleImages[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        },
                         to:WebUrl.CLASSIFIED_LIST_URL+"?token="+token)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                    self.view.makeToast("Sucessfull Updated")
                    
                })
                
                upload.responseJSON { response in
                    print(response.result.value)
                }
                let alert = UIAlertController(title: "Alert", message: "Your Request Has Been Saved ", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        self.dismiss(animated: true, completion: nil)
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                        
                    }}))
                self.present(alert, animated: true, completion: nil)
                
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    /************************** Upload Image End **************************/
    
    func getLocationList(){
        self.view.makeToastActivity(.center)
        let token : String = UserDefaults.standard.string(forKey: "token")!
        print("Token : \(token)")
        
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
                        
          self.locationList.append(LocationModel(dealerName: dealerName, city: city, state: state))
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



