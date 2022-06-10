//
//  MeTeaIExplainationCell.swift
//  Daru
//
//  Created by 재영신 on 2022/05/22.
//

import UIKit
import SnapKit
import Then

final class MBTeaIExplainationCell: UICollectionViewCell {
    static let identifier = "MBTeaIExplainationCell"
    
    private let mainLabel = UnderLineLabel(color: .brown3!, weight: 10.0).then {
        $0.font = .notoSansKR(.bold, size: 20.0)
        $0.text = "MB.Tea.I란?"
        $0.textAlignment = .center
    }
    
    private let secondaryLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 14.0)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.89
        $0.attributedText = NSMutableAttributedString(
            string: """
            개인에게 맞는 차 성향 검사로, 자신이 무슨 차를
            좋아할지에 대해서 알려주는 성향 검사입니다.
            
            성향검사를 통해 이제 고민하지 말고
            자신있게 스스로에게 맞는 차와 찻집을 찾아보세요
            """,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        )
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .gray3
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
            contentView.addSubview($0)
        }
        
        contentView.backgroundColor = .brown3?.withAlphaComponent(0.15)
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20.0)
            make.width.equalTo(mainLabel.intrinsicContentSize)
            make.centerX.equalToSuperview()
        }
        
        secondaryLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20.0)
            make.top.equalTo(mainLabel.snp.bottom).offset(20.0)
            make.bottom.equalToSuperview().inset(25.0)
        }
    }
}
