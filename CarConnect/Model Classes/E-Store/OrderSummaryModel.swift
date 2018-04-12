//
//  OrderSummaryModel.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/23/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation
struct OrderSummaryModel {
    let placeBy: String!
    let orderId: String!
    let pointEarn: String!
    let pointRedeem: String!
    let oAmount: String!
    let invoiceDate: String!
    
    init(placeBy: String!,orderId: String!,pointEarn: String!, pointRedeem: String!,oAmount: String!,invoiceDate: String!) {
        
        self.placeBy = placeBy
        self.orderId = orderId
        self.pointEarn = pointEarn
        self.pointRedeem = pointRedeem
        self.oAmount = oAmount
        self.invoiceDate = invoiceDate
    }
    
}
