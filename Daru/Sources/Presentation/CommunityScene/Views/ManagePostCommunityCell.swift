//
//  ManagePostCommunityCell.swift
//  Daru
//
//  Created by 재영신 on 2022/05/27.
//

import UIKit
import SnapKit
import Then

enum ManagePostItemType: CaseIterable {
    case myPost
    case scrap
    case communityRole
    case usageRestrictionList
    
    var icon: UIImage? {
        switch self {
        case .myPost:
            return Constant.myPostIcon
        case .scrap:
            return Constant.scrapIcon
        case .communityRole:
            return Constant.communityRoleIcon
        case .usageRestrictionList:
            return Constant.usageRestrictionListIcon
        }
    }
    
    var title: String {
        switch self {
        case .myPost:
            return "내가 쓴 글"
        case .scrap:
            return "스크랩한 글"
        case .communityRole:
            return "커뮤니티 이용 규칙"
        case .usageRestrictionList:
            return "이용제한내역"
        }
    }
}

final class ManagePostCommunityCell: UICollectionViewCell {
    
    static let identifier = "ManagePostCommunityCell"
    
    private let iconImageView = UIImageView()
    
    private let mainLabel = UILabel().then {
        $0.font = .notoSansKR(.medium, size: 16.0)
        $0.textColor = .gray3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        
        [
            iconImageView,
            mainLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(22.0)
        }
        iconImageView.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        iconImageView.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(27.0)
            make.top.equalTo(iconImageView.snp.bottom).offset(15.0)
        }
        
    }
    
    func update(with item: ManagePostItemType) {
        iconImageView.image = item.icon
        mainLabel.text = item.title
    }
}

