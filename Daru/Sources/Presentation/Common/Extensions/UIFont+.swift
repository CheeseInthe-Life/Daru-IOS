//
//  UIFont+.swift
//  Daru
//
//  Created by 재영신 on 2022/05/17.
//

import UIKit

extension UIFont {
    // MARK: - NotoSansKR
       public enum NotoSansKRType{
           case bold
           case regular
           case medium

           var name: String {
               switch self {
               case .bold:
                   return "NotoSansKR-Bold"
               case .regular:
                   return "NotoSansKR-Regular"
               case .medium:
                   return "NotoSansKR-Medium"
               }
           }
       }

       static func NotoSansKR(_ type: NotoSansKRType, size: CGFloat) -> UIFont {
           return UIFont(name: type.name, size: size)!
       }
}
