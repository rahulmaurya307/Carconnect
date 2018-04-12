//
//  CircularView.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 11/24/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit
extension UIView {
    func makeCircular() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
}
