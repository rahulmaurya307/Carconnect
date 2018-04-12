//
//  NewCars.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/16/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation

struct NewCars {
    
    let  modelImage : String!
    let  id : String!
    let  price : String!
    let  brandName : String!
    let  modelName : String!
    
init(modelImage : String,id : String,price : String,brandName : String,modelName : String) {
            
            self.modelImage = modelImage
            self.id = id
            self.price = price
            self.brandName = brandName
            self.modelName = modelName
        }

    
}
