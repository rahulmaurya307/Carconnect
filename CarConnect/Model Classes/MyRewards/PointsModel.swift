//
//  PointsModel.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/20/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation

struct PointsModel {
    let serviceName :String!
    let awardPoints :String!
    let redeemPoint :String!
    let txnCreatedAt :String!
    let invoiceDate :String!
    let expiry :String!
    let activation :String!
    let pendingStatus : Bool!
    let isExpiry : Bool!
    
init(serviceName :String!,awardPoints :String!,redeemPoint :String!,txnCreatedAt :String!,invoiceDate :String!,expiry :String!,activation :String!, pendingStatus :Bool!,
     isExpiry :Bool!) {
    
        self.serviceName = serviceName
        self.awardPoints = awardPoints
        self.redeemPoint = redeemPoint
        self.txnCreatedAt = txnCreatedAt
        self.invoiceDate = invoiceDate
        self.expiry = expiry
        self.activation = activation
        self.pendingStatus = pendingStatus
        self.isExpiry = isExpiry
      
    }
    
}
