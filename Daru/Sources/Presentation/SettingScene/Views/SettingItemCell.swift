//
//  SettingItemCell.swift
//  Daru
//
//  Created by 재영신 on 2022/06/18.
//

import UIKit
import SnapKit
import Then

final class SettingItemCell: UITableViewCell {
    
    static let identifier = "\(type(of: SettingItemCell.self))"
    
    private let titleLabel = UILabel().then {
        $0.font = .notoSansKR(.medium, size: 18.0)
        $0.textColor = .gray1
    }
    
    private let moreButton = UIButton().then {
        $0.setImage(Constant.chevronIcon, for: .normal)
        $0.backgroundColor = .white
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        removeSeparators()
    }
    
    private func configureUI() {
        
        [
            titleLabel,
            moreButton
        ].forEach {
            contentView.addSubview($0)
        }
        
        selectionStyle = .none
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16.0)
            make.leading.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(13.0)
            make.width.height.equalTo(24.0)
        }
    }
    
    func update(with type: SettingItemType) {
        titleLabel.text = type.title
    }
}
