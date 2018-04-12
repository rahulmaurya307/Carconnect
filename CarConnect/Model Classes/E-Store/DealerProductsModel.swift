//
//  DealerProductsModel.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/23/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation
struct DealerProductsModel {
    let productId :String!
    let productName :String!
    let price :String!
    let productImage :String!
    let productDescription :String!
    let productSpecification :String!
    let associateId :String!
    let inventory : String!
    let productSold : String!
    
init(  productId :String!,productName :String!,price :String!,productImage :String!,
       productDescription :String!,productSpecification :String!,associateId :String!,
       inventory : String!,productSold : String!) {
        
        self.productId = productId
        self.productName = productName
        self.price = price
        self.productImage = productImage
        self.productDescription = productDescription
        self.productSpecification = productSpecification
        self.associateId = associateId
        self.inventory = inventory
        self.productSold = productSold
        
    }
    
}
