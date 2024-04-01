//
//  UIColor.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import UIKit

extension UIColor {
    static let theme = AppColor()
    
    static func randomColor() -> UIColor {
        let randomRed = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
}
struct AppColor {
    let backgroundColor = UIColor.white
    
    let primaryButtonColor = UIColor.orange
    let primaryButtonTextColor = UIColor.white
    
    let primaryColor = UIColor.orange
    let primaryTextColor = UIColor.black
}
