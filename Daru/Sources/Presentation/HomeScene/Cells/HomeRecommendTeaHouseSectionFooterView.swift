//
//  RecommendTeaHouseFooterView.swift
//  Daru
//
//  Created by 재영신 on 2022/05/18.
//

import UIKit
import SnapKit
import Then

final class HomeRecommendTeaHouseSectionFooterView: UICollectionReusableView {
    static let identifier = "HomeRecommendTeaHouseSectionFooterView"
    
    private let mainLabel = UILabel().then {
        $0.font = .notoSansKR(.medium, size: 14.0)
        $0.textColor = .brown1
        $0.text = "※ 추천된 찻집이 마음에 들지 않는다면?"
    }
    
    private let moveSettingButton = UIButton().then {
        $0.backgroundColor = .brown1
        $0.setTitle("설정하러 가기", for: .normal)
        $0.titleLabel?.font = .notoSansKR(.regular, size: 12.0)
        $0.layer.cornerRadius = 4.0
        $0.contentEdgeInsets = .init(top: 4.0, left: 11.0, bottom: 4.0, right: 11.0)
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
        
        [
            mainLabel,
            moveSettingButton
        ].forEach {
            addSubview($0)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(14.0)
            make.centerY.equalToSuperview()
        }
        
        moveSettingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20.0)
            make.leading.equalTo(mainLabel.snp.trailing)
            make.top.bottom.equalToSuperview()
        }
        
        moveSettingButton.setContentHuggingPriority(.required, for: .horizontal)
    }
}
