//
//  RegionCategoryCell.swift
//  Daru
//
//  Created by 재영신 on 2022/05/21.
//

import UIKit
import SnapKit
import Then

final class RegionCategoryCell: UICollectionViewCell {
    static let identifier = "RegionCategoryCell"
    
    private let mainImageView = UIImageView().then {
        $0.image = Constant.dummyRegionImage
    }
    
    private let nameLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.text = "서울"
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
            mainImageView,
            nameLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        contentView.layer.cornerRadius = 15.0
        
        mainImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        mainImageView.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        mainImageView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(mainImageView.snp.bottom).offset(10.0)
            make.bottom.equalToSuperview().inset(10.0)
        }
    }
}
