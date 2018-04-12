//
//  BrandHelpline.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/20/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation


struct BrandHelpline {
    let id : String!
    let brandName : String!
    let brandImage : String!
    let contact : String!

    
    init(id : String, brandName : String, brandImage : String, contact : String) {
        self.id = id
        self.brandName = brandName
        self.brandImage = brandImage
        self.contact = contact

        
    }
    
}


