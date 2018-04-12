//
//  MySideMenu.swift
//  CarConnect
//
//  Created by Rahul on 04/11/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit

class MySideMenu: UIView,ENSideMenuDelegate {
    
    
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        return true
    }

    
}
