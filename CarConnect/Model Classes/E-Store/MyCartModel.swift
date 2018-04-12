//
//  MyCartModel.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/28/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation
struct MyCartModel {
    
    
    let cartId : String!
    let productId : String!
    let quantity : String!
    let productName : String!
    let productState : String!
    let productImage : String!
    let price : String!
    let inventory: String!
    let productSold : String!
    let itemLeft : Int!
    
  
    
    
    init(cartId : String!,productId : String!,quantity : String!,productName : String!,productState : String!,productImage : String!,price : String!,inventory: String!,productSold : String!, itemLeft : Int!)
    {
        
        self.cartId = cartId
        self.productId = productId
        self.quantity = quantity
        self.productName = productName
        self.productState = productState
        self.productImage = productImage
        self.price = price
        self.inventory = inventory
        self.productSold = productSold
        self.itemLeft = itemLeft
    }
    
}

