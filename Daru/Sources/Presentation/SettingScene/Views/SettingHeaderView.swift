//
//  SettingHeaderView.swift
//  Daru
//
//  Created by 재영신 on 2022/06/18.
//

import UIKit
import SnapKit
import Then

final class SettingHeaderView: UIView {
    
    private let titleLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
        $0.textColor = .tit_brwon
        $0.text = "TEST"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(15.0)
            make.top.equalToSuperview().inset(20.0)
        }
    }
}
