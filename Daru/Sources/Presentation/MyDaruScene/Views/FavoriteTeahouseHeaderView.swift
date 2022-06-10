//
//  FavoriteTeahouseHeaderView.swift
//  Daru
//
//  Created by 재영신 on 2022/05/24.
//

import UIKit
import SnapKit
import Then

final class FavoriteTeaHouseHeaderView: UICollectionReusableView {
    
    static let identifier = "FavoriteTeaHouseHeaderView"
    
    private let mainLabel = UnderLineLabel(color: .brown3!, weight: 10.0).then {
        $0.font = .notoSansKR(.bold, size: 20.0)
        $0.text = "내가 좋아하는 찻집"
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        
        addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(20.0)
        }
        
    }
}
