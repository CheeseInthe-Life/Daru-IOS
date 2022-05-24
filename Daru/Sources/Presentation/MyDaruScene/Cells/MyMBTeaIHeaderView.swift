//
//  MyMBTeaIHeaderView.swift
//  Daru
//
//  Created by 재영신 on 2022/05/24.
//

import UIKit
import SnapKit
import Then

final class MyMBTeaIHeaderView: UICollectionReusableView {
    
    static let identifier = "MyMBTeaIHeaderView"
    
    private let mainLabel = UnderLineLabel(color: .brown3!, weight: 10.0).then {
        $0.font = .notoSansKR(.bold, size: 20.0)
        $0.text = "MB.Tea.I란?"
        $0.textAlignment = .center
    }
    
    private let secondaryLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.textColor = .gray3
        $0.text = "나의 MB.Tea.I에 따라 찻집을 추천받을 수 있어요!"
        $0.textAlignment = .center
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
            secondaryLabel
        ].forEach {
            addSubview($0)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20.0)
        }
        
        secondaryLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20.0)
            make.top.equalTo(mainLabel.snp.bottom).offset(20.0)
            make.bottom.equalToSuperview().inset(20.0)
        }
    }
}
