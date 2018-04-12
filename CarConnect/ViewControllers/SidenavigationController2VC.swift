//
//  SidenavigationController2VC.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 3/22/18.
//  Copyright © 2018 Aritron Technologies. All rights reserved.
//

import UIKit

class SidenavigationController2VC: ENSideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let menu = storyboard.instantiateViewController(withIdentifier: "MenuTableViewController") as!
        MenuTableViewController
        
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: menu, menuPosition: ENSideMenuPosition.left)
        sideMenu?.menuWidth = 280
        view.bringSubview(toFront: navigationBar)
    }
    
}

 

