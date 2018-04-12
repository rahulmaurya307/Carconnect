//
//  TrackReferals.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/21/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation
struct TrackReferals {
    
    
    let  referralId : String!
    let  name : String!
    let  referralStatus : String!
    let  referralEmail : String!
    let  referralName : String!
    let  referralMobile : String!
    
    
    init(referralId : String!,
      name : String!,
      referralStatus : String!,
      referralEmail : String!,
      referralName : String!,
      referralMobile : String!) {
        self.referralId = referralId
        self.name = name
        self.referralStatus = referralStatus
        self.referralEmail = referralEmail
        self.referralName = referralName
        self.referralMobile = referralMobile
    }
    
    
}
