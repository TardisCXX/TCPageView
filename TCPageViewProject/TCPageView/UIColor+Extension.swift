//
//  UIColor+Extension.swift
//  TCPageViewProject
//
//  Created by tardis_cxx on 2017-5-12.
//  Copyright © 2017年 tardis_cxx. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    /// 随机颜色
    class var randomColor: UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    convenience init?(hex: String?, alpha: CGFloat = 1.0) {
        guard let hex = hex else {
            return nil;
        }
        if hex.characters.count < 6 {
            return nil;
        }
        
        var hexString = hex.uppercased()
        
        if hexString.hasPrefix("##") || hexString.hasPrefix("0X") {
            hexString = (hexString as NSString).substring(from: 2)
        }
        
        if hexString.hasPrefix("#") {
            hexString = (hexString as NSString).substring(from: 1)
        }
        
        var range = NSRange(location: 0, length: 2)
        let rStr = (hexString as NSString).substring(with: range)
        
        range.location = 2
        let gStr = (hexString as NSString).substring(with: range)
        
        range.location = 4
        let bStr = (hexString as NSString).substring(with: range)
        
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), alpha: alpha)
    }
    
}
