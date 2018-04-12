
//
//  OrderDetailModel.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 12/22/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation
struct OrderDetailModel {
    
           let orderId : String!
           let productId : String!
           let productName : String!
           let quantity : String!
           let price : String!
           let totalAmount : String!
           let productImage : String!
           let couponValue : String!
           let voucherValue : String!
           let pointRedeem : String!
           let pointEarn : String!
           let paidAmount : String!
           let orderDate : String!
           let orderState : String!
    
    
    init(  orderId : String!,
     productId : String!,
     productName : String!,
     quantity : String!,
     price : String!,
     totalAmount : String!,
     productImage : String!,
     couponValue : String!,
     voucherValue : String!,
     pointRedeem : String!,
     pointEarn : String!,
     paidAmount : String!,
     orderDate : String!,
     orderState : String!) {
        
        self.orderId = orderId
        self.productId = productId
        self.productName = productName
        self.quantity = quantity
        self.price = price
        self.totalAmount = totalAmount
        self.productImage = productImage
        self.couponValue = couponValue
        self.voucherValue = voucherValue
        self.pointRedeem = pointRedeem
        self.pointEarn = pointEarn
        self.paidAmount = paidAmount
        self.orderDate = orderDate
        self.orderState = orderState
        
     
    }
    
}

