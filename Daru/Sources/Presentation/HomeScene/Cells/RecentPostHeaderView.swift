//
//  CommunityHeaderView.swift
//  Daru
//
//  Created by 재영신 on 2022/05/18.
//

import UIKit
import SnapKit
import Then

final class RecentPostHeaderView: UICollectionReusableView {
    static let identifier = "RecentPostHeaderView"
    
    private let titleLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
        $0.text = "지금 다루 커뮤니티는"
    }
    
    private let moreButton = UIButton().then {
        $0.setImage(Constant.arrowIcon, for: .normal)
        $0.tintColor = .gray2
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.gray2, for: .normal)
        $0.titleLabel?.font = .notoSansKR(.regular, size: 12.0)
        $0.imageEdgeInsets = .init(top: 0.0, left: 0.0, bottom: 0.0, right: 6.0)
        $0.layer.borderColor = UIColor.gray4?.cgColor
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 4.0
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
            titleLabel,
            moreButton
        ].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().inset(35.0)
            make.bottom.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints { make in
            make.center.equalTo(titleLabel)
            make.trailing.equalToSuperview()
            make.width.equalTo(64.0)
            make.height.equalTo(24.0)
        }
    }
}
