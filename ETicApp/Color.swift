//
//  Color.swift
//  ETicApp
//
//  Created by Bilal Candemir on 12.01.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import Foundation
import UIKit

struct Color {
    static let tintColor = UIColor.orange
    static let textColor = Color.UIColorFromRGB(rgbValue: 0x00000)
    static let backgroundColor = Color.UIColorFromRGB(rgbValue: 0x27D144)
    static let actionSheetColor = UIColor.black
    
    
    static func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
