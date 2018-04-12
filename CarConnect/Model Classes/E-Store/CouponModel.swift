//
//  CouponModel.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/24/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation

struct CouponModel {
    var productId :String!
    var couponDescription :String!
    var expiryDate :String!
    var couponSpecification :String!
    var autoId :String!
    var inventory :String!
    var couponImage :String!
    var couponStatus :String!
    var couponCode :String!
    var couponName :String!
    var couponPrice :String!
    var couponId :String!
    
init(productId :String!,couponDescription :String!,expiryDate:String!,couponSpecification :String!,autoId :String!,inventory :String!,couponImage:String!,couponStatus :String!,couponCode :String!,couponName :String!,couponPrice :String!,couponId :String!){
    
    
        self.productId = productId
        self.couponDescription = couponDescription
        self.expiryDate = expiryDate
        self.autoId = autoId
        self.inventory = inventory
        self.couponImage = couponImage
        self.couponStatus = couponStatus
        self.couponCode = couponCode
        self.couponName = couponName
        self.couponPrice = couponPrice
        self.couponId = couponId
    }
    
}

