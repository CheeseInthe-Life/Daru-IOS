//
//  UIColor.swift
//  Daru
//
//  Created by 재영신 on 2022/05/17.
//

import UIKit

extension UIColor {
    
    class var gray1: UIColor? { return UIColor(named: "Gray1") }
    class var gray2: UIColor? { return UIColor(named: "Gray2") }
    class var gray3: UIColor? { return UIColor(named: "Gray3") }
    class var gray4: UIColor? { return UIColor(named: "Gray4") }
    class var gray5: UIColor? { return UIColor(named: "Gray5") }
    class var gray6: UIColor? { return UIColor(named: "Gray6") }
    class var gray7: UIColor? { return UIColor(named: "Gray7") }
    
    class var brown1: UIColor? { return UIColor(named: "Brown1") }
    class var brown2: UIColor? { return UIColor(named: "Brown2") }
    class var brown3: UIColor? { return UIColor(named: "Brown3") }
    
    class var blueGreen1: UIColor? { return UIColor(named: "BlueGreen1") }
    class var blueGreen2: UIColor? { return UIColor(named: "BlueGreen2") }
    
    class var yellowGreen1: UIColor? { return UIColor(named: "YellowGreen1") }
    class var yellowGreen2: UIColor? { return UIColor(named: "YellowGreen2") }
    
    class var navy1: UIColor? { return UIColor(named: "Navy1") }
    class var navy2: UIColor? { return UIColor(named: "Navy2") }
    
    class var lineBrown: UIColor? { return UIColor(named: "Line_Brown") }
    class var tit_brwon: UIColor? { return UIColor(named: "TitBrown") }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0)
    {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
            
        }
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha
        )
    }
}


