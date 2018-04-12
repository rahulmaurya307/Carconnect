//
//  DealerModel.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/22/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation

struct DealerModel {
    
    
    let  offerDescription : String!
    let  offerImage : String!
    let  offerName : String!
    
    
    init(offerDescription : String,offerImage : String,offerName : String) {
        self.offerDescription = offerDescription
        self.offerImage = offerImage
        self.offerName = offerName
    }
    
    
}
