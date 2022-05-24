//
//  MyFavoriteTeaCell.swift
//  Daru
//
//  Created by 재영신 on 2022/05/24.
//

import UIKit
import SnapKit
import Then

final class MyFavoriteTeaCell: UICollectionViewCell {
    
    static let identifier = "MyFavoriteTeaCell"
    
    private let teaNameLabel = UILabel().then {
        $0.font = .notoSansKR(.medium, size: 16.0)
        $0.text = "백차"
        $0.textColor = .brown1
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.bounds.height / 2.0
    }
    
    private func configureUI() {
        
        contentView.addSubview(teaNameLabel)
        
        teaNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8.0)
        }
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.brown1?.cgColor
    }
}
