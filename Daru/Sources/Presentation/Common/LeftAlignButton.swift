//
//  LeftAlignButton.swift
//  Daru
//
//  Created by 재영신 on 2022/06/13.
//

import UIKit

class LeftAlignButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        contentHorizontalAlignment = .left
        let availableSpace = bounds.inset(by: contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: availableWidth / 2 - 15, bottom: 0, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 0)
    }
}
