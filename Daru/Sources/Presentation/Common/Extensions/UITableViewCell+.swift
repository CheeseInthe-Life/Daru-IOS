//
//  UITableViewCell+.swift
//  Daru
//
//  Created by 재영신 on 2022/06/18.
//

import UIKit

extension UITableViewCell {
    func removeSeparators() {
           for subview in subviews {
               if subview != contentView && subview.frame.width != frame.width {
                   subview.removeFromSuperview()
               } else if subview != contentView && subview.frame.width == frame.width {
                   subview.frame = subview.frame.with({
                       $0.size.height = $0.height + 1.0
                   })
               }
           }
       }
}
