//
//  SelectCar.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 12/8/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation
struct SelectCar {
    let id : String!
    let brandImage : String!
    let brandName : String!
    
    init(id : String, brandImage : String, brandName : String) {
        self.id = id
        self.brandImage = brandImage
        self.brandName = brandName
    }
    
}
