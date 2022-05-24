//
//  PrimaryButton.swift
//  Daru
//
//  Created by 재영신 on 2022/05/24.
//

import UIKit

class PrimaryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        backgroundColor = .brown2
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .notoSansKR(.bold, size: 16.0)
        layer.cornerRadius = 6.0
    }
    
}
