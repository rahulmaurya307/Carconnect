//
//  UsedCar.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/16/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation
struct UsedCar{
    
    let modelName : String!
    let state : String!
    let carId : String!
    let updated_at : String!
    let vehicleImages2 : String!
    let variantName : String!
    let kmsdriven : String!
    let brandName : String!
    let color : String!
    let carStatus : String!
    let status : String!
    let updatedBy : String!
    let updatedType : String!
    let id : String!
    let vehicleImages1 : String!
    let vehicleImages3 : String!
    let created_at : String!
    let modelYear : String!
    let owner : String!
    let price : String!
    let comment : String!
    let dealerId : String!
    let registration : String!
    
init( modelName : String,state : String,carId : String,updated_at : String,vehicleImages2 : String,variantName : String,kmsdriven : String,brandName : String,color : String,carStatus : String,status : String,updatedBy : String,updatedType : String,id : String,vehicleImages1 : String,vehicleImages3 : String,created_at : String,modelYear : String,owner : String,price : String,comment : String,dealerId : String,registration : String) {
        
        
       self.modelName = modelName
       self.state = state
       self.carId = carId
       self.updated_at = updated_at
       self.vehicleImages2 = vehicleImages2
       self.variantName = variantName
       self.kmsdriven = kmsdriven
       self.brandName = brandName
       self.color  = color
       self.carStatus = carStatus
       self.status = status
       self.updatedBy = updatedBy
       self.updatedType = updatedType
       self.id = id
       self.vehicleImages1 = vehicleImages1
       self.vehicleImages3 = vehicleImages3
       self.created_at = created_at
       self.modelYear = modelYear
       self.owner = owner
       self.price = price
       self.comment = comment
       self.dealerId = dealerId
       self.registration = registration
        
    }

}
