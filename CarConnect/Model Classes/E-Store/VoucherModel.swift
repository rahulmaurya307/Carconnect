//
//  VoucherModel.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/24/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation
struct VoucherModel {
    let updated_at : String!
    let voucherDescription : String!
    let associateName : String!
    let voucherStatus : String!
    let tierId : String!
    let updatedBy : String!
    let updatedType : String!
    let id : String!
    let voucherTypeId : String!
    let created_at : String!
    let associateId : String!
    let voucherState : String!
    let voucherName : String!

    
    init(  updated_at : String!,
     voucherDescription : String!,
     associateName : String!,
     voucherStatus : String!,
     tierId : String!,
     updatedBy : String!,
     updatedType : String!,
     id : String!,
     voucherTypeId : String!,
     created_at : String!,
     associateId : String!,
     voucherState : String!,
     voucherName : String!)
    {
        
        self.updated_at = updated_at
        self.voucherDescription = voucherDescription
        self.associateName = associateName
        self.voucherStatus = voucherStatus
        self.tierId = tierId
        self.updatedBy = updatedBy
        self.updatedType = updatedType
        self.id = id
        self.voucherTypeId = voucherTypeId
        self.created_at = created_at
        self.associateId = associateId
        self.voucherState = voucherState
        self.voucherName = voucherName
    }
    
}
