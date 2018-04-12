//
//  MyCars.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/16/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation

struct MyCars {
    
    
    let chassNo : String!
    let usermobile : String!
    let modelImage : String!
    let updated_at : String!
    let expiryDate : String!
    let loyaltyId : String!
    let colorCode : String!
    let variantName : String!
    let brandName : String!
    let updatedBy : String!
    let location : String!
    let updatedType : String!
    let id : String!
    let status : String!
    let registrationNo : String!
    let created_at : String!
    let modelYear : String!
    let modelName : String!


    init(chassNo : String, usermobile : String,modelImage : String,updated_at : String,expiryDate : String,loyaltyId : String,colorCode : String,variantName : String,brandName : String,updatedBy : String,location : String,updatedType : String,id : String,status : String,registrationNo : String,created_at : String,modelYear : String,modelName : String) {
        
        
        self.chassNo = chassNo
        self.usermobile = usermobile
        self.modelImage = modelImage
        self.updated_at = updated_at
        self.expiryDate = expiryDate
        self.loyaltyId = loyaltyId
        self.colorCode = colorCode
        self.updatedBy = updatedBy
        self.variantName = variantName
        self.brandName = brandName
        self.location = location
        self.updatedType = updatedType
        self.id = id
        self.status = status
        self.registrationNo = registrationNo
        self.created_at = created_at
        self.modelYear = modelYear
        self.modelName = modelName
       
       
    }
}


