//
//  ColorModelBD.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/30/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation
struct ColorModelBD {
    
    let id : String!
    let colorName : String!
    let colorCode : String!
    
    init(id: String!,colorName: String!,colorCode : String!) {
        
        self.id = id
        self.colorName = colorName
        self.colorCode = colorCode
        
    }
}
