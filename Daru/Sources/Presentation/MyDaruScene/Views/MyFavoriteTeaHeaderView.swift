//
//  MyFavoriteTeaCell.swift
//  Daru
//
//  Created by 재영신 on 2022/05/24.
//

import UIKit
import SnapKit
import Then

final class MyFavoriteTeaHeaderView: UICollectionReusableView {
    
    static let identifier = "MyFavoriteTeaHeaderView"
    
    private let mainLabel = UnderLineLabel(color: .brown3!, weight: 10.0).then {
        $0.font = .notoSansKR(.bold, size: 20.0)
        $0.text = "내가 좋아하는 차(10개까지 선택)"
        $0.textAlignment = .center
    }
    
    private let secondaryLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.textColor = .gray3
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.89
        paragraphStyle.alignment = .center
        $0.attributedText = NSMutableAttributedString(
            string: "자신이 좋아하는 차를 선택해보세요!\n기존 추천되는 찻집에 변화를 줄 수 있습니다!",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        $0.numberOfLines = 2
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
            make.top.equalTo(mainLabel.snp.bottom).offset(20.0)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
