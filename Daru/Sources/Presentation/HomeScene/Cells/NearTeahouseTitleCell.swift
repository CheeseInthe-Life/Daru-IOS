//
//  NearTeahouseTitleCell.swift
//  Daru
//
//  Created by 재영신 on 2022/05/30.
//

import UIKit
import SnapKit
import Then

final class TeahouseListTitleCell: UICollectionViewCell {
    
    static let identifier = "\(type(of: self))"
    
    private let titleLabel = UILabel().then {
        let str = NSMutableAttributedString(string: "내 주변 찻집")
        $0.textAlignment = .center
    }
    
    private let secondaryLabel = UILabel().then {
        let str = NSMutableAttributedString(string: "")
        let icon = NSTextAttachment(image: Constant.curLocationIcon!)
        str.append(NSAttributedString(attachment: icon))
        str.append(NSAttributedString(string: " 현재 위치 : 서울, 관악구"))
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
    
    //TODO: title -> 유효한 데이터
    func update(with title: String) {
        let str = NSMutableAttributedString(string: title)
        print(str.length)
        str.addAttributes(
            [
                .foregroundColor: UIColor.tit_brwon!,
                .font: UIFont.notoSansKR(.medium, size: 22.0)
            ],
            range: NSRange(location: 0, length: title.count - 3)
        )
        str.addAttributes(
            [
                .foregroundColor: UIColor.tit_brwon!,
                .font: UIFont.notoSansKR(.bold, size: 24.0)
            ],
            range: NSRange(location: title.count - 2, length: 2)
        )
        titleLabel.attributedText = str
    }
}
