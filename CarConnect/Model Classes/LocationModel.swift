//
//  LocationModel.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 4/11/18.
//  Copyright © 2018 Aritron Technologies. All rights reserved.
//

import Foundation

struct LocationModel {
    let  dealerName : String!
    let  city : String!
    let  state : String!
   
    init(dealerName : String,city : String,state : String) {
        self.dealerName = dealerName
        self.city = city
        self.state = state
    }
}

