
import UIKit

class LoanCalculateViewController: UIViewController {
    @IBOutlet var txtFldPrincAmount: UITextField!
    @IBOutlet var txtFldInterest: UITextField!
    @IBOutlet var txtFldTimeDuration: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = MySideMenu()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
   
    @IBAction func btnCalculator(_ sender: Any) {
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }

}
