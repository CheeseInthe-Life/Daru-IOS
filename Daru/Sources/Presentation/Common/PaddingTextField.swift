//
//  PaddingTextField.swift
//  Daru
//
//  Created by 재영신 on 2022/06/17.
//

import UIKit

class PaddingTextField: UITextField {

    var padding: UIEdgeInsets?

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding ?? .zero)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding ?? .zero)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding ?? .zero)
    }
}
