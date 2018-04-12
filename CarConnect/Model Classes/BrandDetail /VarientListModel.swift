//
//  VarientListModel.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 12/1/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation
struct VarientListModel {
    
    let id : String!
   let variantName : String!
   let variantPower : String!
   let variantmileage : String!
  let  price : String!
    
    
    init(id : String!,
     variantName : String!,
     variantPower : String!,
     variantmileage : String!,
      price : String!) {
        
        self.id = id
        self.variantName = variantName
        self.variantPower = variantPower
        self.variantmileage = variantmileage
        self.price = price
     
        
    }
}
