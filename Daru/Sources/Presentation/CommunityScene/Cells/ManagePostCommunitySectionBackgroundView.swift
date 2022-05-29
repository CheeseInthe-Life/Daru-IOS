//
//  ManagePoseCommunitySectionBackgroundView.swift
//  Daru
//
//  Created by 재영신 on 2022/05/27.
//

import UIKit
import SnapKit
import Then

final class ManagePostCommunitySectionBackgroundView: UICollectionReusableView {
    
    static let identifier = "ManagePostCommunitySectionBackgroundView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        backgroundColor = .gray7?.withAlphaComponent(0.7)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.gray5?.cgColor
    }
    
}
