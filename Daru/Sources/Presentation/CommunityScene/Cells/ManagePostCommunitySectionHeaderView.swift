//
//  ManagePostComunitySectionHeaderView.swift
//  Daru
//
//  Created by 재영신 on 2022/05/27.
//

import UIKit
import SnapKit
import Then

final class ManagePostCommunitySectionHeaderCell: UICollectionViewCell {
    static let identifier = "ManagePostCommunitySectionHeaderCell"
    
    private let mainLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
        $0.text = "커뮤니티"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        
        contentView.addSubview(mainLabel)
        
        // decorationView의 backgroundColor지정 시 헤더까지 색상이 변경돼서 헤더 색상은 따로 지정
        contentView.backgroundColor = .systemBackground
        
        mainLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20.0)
            make.top.equalToSuperview().inset(25.0)
            make.bottom.equalToSuperview().inset(10.0)
        }
    }
}
