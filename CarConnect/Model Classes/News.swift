//
//  News.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/17/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import Foundation
struct NewsStruct {
    var description : String!
    var title : String!
    var id : String!
    var image : String!
    var created_at : String!
    
    
init( description : String!,title : String!,id : String!,image : String!,created_at : String!) {
        
        self.description = description
        self.title = title
        self.id = id
        self.image = image
        self.created_at = created_at
        
    }
    
}


