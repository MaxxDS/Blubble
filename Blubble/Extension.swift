//
//  Extension.swift
//  Blubble
//
//  Created by Maxime DeSaint on 5/5/17.
//  Copyright © 2017 Maxime DeSaint. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

extension UIColor
{
    class func myGreenColor() -> UIColor
    {
        return UIColor(red: 0.400, green: 1.000, blue: 0.800, alpha: 1.0)/*#66CCFF*/
    }
}
