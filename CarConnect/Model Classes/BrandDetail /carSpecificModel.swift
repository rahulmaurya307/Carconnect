//
//  carSpecificModel.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 12/6/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation
struct carSpecificModel {
    
    let specificationName : String!
    let specificationvalue : String!
   
    
    
    init(specificationName : String!,
         specificationvalue : String!) {
        
        self.specificationName = specificationName
        self.specificationvalue = specificationvalue 
        
    }
}

