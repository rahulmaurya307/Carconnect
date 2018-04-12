//
//  SidenavigationController.swift
//  SideMenuExample
//
//  Created by Saurabh Sharma on 10/5/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit


class SidenavigationController: ENSideMenuNavigationController {

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
