//
//  ColorModel.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 12/12/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation
struct ColorModel {
    let id : String!
    let colorName : String!
    let colorCode : String!
    
    init(id : String!, colorName : String!, colorCode : String!) {
        self.id = id
        self.colorName = colorName
        self.colorCode = colorCode
    }
    
}

