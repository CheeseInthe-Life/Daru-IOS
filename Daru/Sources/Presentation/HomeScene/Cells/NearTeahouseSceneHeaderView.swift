//
//  NearTeahouseHeaderView.swift
//  Daru
//
//  Created by 재영신 on 2022/05/30.
//

import UIKit
import SnapKit
import Then

final class NearTeahouseSceneHeaderView: UICollectionReusableView {
    
    static let identifier = "\(type(of: self))"
    
    private let titleLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
        $0.text = "내 주변 찻집"
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
            make.top.bottom.equalToSuperview().inset(18.0)
        }
    }
}
