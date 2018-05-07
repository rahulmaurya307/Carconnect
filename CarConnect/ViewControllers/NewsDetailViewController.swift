//
//  NewsDetailViewController.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/2/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsDetailViewController: UIViewController {
    
    var newsImage : String!
    var newsTitle : String!
    var newsDesc : String!

    @IBOutlet weak var uiNewsTitle: UILabel!
    @IBOutlet weak var uiNewsDesc: UITextView!
    @IBOutlet weak var uiNewsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: newsImage)!
        uiNewsImage.af_setImage(withURL: url)
        
        uiNewsTitle.text = newsTitle
        uiNewsDesc.text = newsDesc
        
        print(newsImage+" Titel  - > " + newsTitle + "Desc ->  "+newsDesc)

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backBtn (_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
