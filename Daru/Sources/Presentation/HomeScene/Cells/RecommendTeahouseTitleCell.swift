//
//  RecommendTeahouseTitleCell.swift
//  Daru
//
//  Created by 재영신 on 2022/05/31.
//

import UIKit
import SnapKit
import Then

final class RecommendTeahouseTitleCell: UICollectionViewCell {
    
    static let identifier = "\(type(of: self))"
    
    private let titleLabel = UILabel().then {
        let str = NSMutableAttributedString(string: "나와 잘 맞는 찻집")
        print(str.length)
        str.addAttributes(
            [
                .foregroundColor: UIColor.tit_brwon!,
                .font: UIFont.notoSansKR(.medium, size: 22.0)
            ],
            range: NSRange(location: 0, length: str.length - 3)
        )
        str.addAttributes(
            [
                .foregroundColor: UIColor.tit_brwon!,
                .font: UIFont.notoSansKR(.bold, size: 24.0)
            ],
            range: NSRange(location: str.length - 2, length: 2)
        )
        $0.attributedText = str
        $0.textAlignment = .center
    }
    
    private let secondaryLabel = UILabel().then {
        let str = NSMutableAttributedString(string: "")
        let icon = NSTextAttachment(image: Constant.frogIcon!)
        str.append(NSAttributedString(string: "나의 MB.Tea.I : 녹차개구리형 "))
        str.append(NSAttributedString(attachment: icon))
        str.addAttributes(
            [
                .foregroundColor: UIColor.tit_brwon!,
                .font: UIFont.notoSansKR(.medium, size: 22.0)
            ],
            range: NSRange(location: 0, length: 11)
        )
        str.addAttributes(
            [
                .foregroundColor: UIColor.tit_brwon!,
                .font: UIFont.notoSansKR(.bold, size: 24.0)
            ],
            range: NSRange(location: 12, length: str.length)
        )
        $0.attributedText = str
        $0.font = .notoSansKR(.medium, size: 14.0)
        $0.textAlignment = .center
    }
    
    private let topDividingLine = UIView().then {
        $0.backgroundColor = .brown3
    }
    
    private let bottomDividingLine = UIView().then {
        $0.backgroundColor = .brown3
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
        //secondaryLabel.layer.addBorder([.top, .bottom], color: .brown3!, width: 5.0)
    }
    
    private func configureUI() {
        
        [
            titleLabel,
            topDividingLine,
            secondaryLabel,
            bottomDividingLine
        ].forEach {
            contentView.addSubview($0)
        }
        
        contentView.backgroundColor = UIColor(hex: "#F3E8DE", alpha: 0.6)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(36.0)
            make.centerX.equalToSuperview()
        }
        
        topDividingLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(7.0)
            make.leading.trailing.equalToSuperview().inset(90.0)
            make.height.equalTo(1.0)
        }
        
        secondaryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(topDividingLine.snp.bottom).offset(7.0)
        }
        
        bottomDividingLine.snp.makeConstraints { make in
            make.top.equalTo(secondaryLabel.snp.bottom).offset(7.0)
            make.leading.trailing.equalToSuperview().inset(90.0)
            make.height.equalTo(1.0)
            make.bottom.equalToSuperview().inset(35.0)
        }
    }
}

