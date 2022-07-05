//
//  CommonItemView.swift
//  Daru
//
//  Created by 재영신 on 2022/07/05.
//

import UIKit
import SnapKit
import Then

final class CommonItemView: UIView {
    
    let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let contentLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 12.0)
        $0.textColor = .gray3
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
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
            contentLabel
        ].forEach {
            addSubview($0)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func update(with icon: UIImage?, _ content: String) {
        iconImageView.image = icon
        contentLabel.text = content
    }
}
