//
//  RegionHeaderView.swift
//  Daru
//
//  Created by 재영신 on 2022/05/21.
//

import UIKit
import SnapKit
import Then

final class RegionCategoryHeaderView: UICollectionReusableView {
    static let identifier = "RegionCategoryHeaderView"
    
    private let titleLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
        $0.text = "지역별로 알아보기"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().inset(35.0)
            make.bottom.equalToSuperview()
        }
    }
}
