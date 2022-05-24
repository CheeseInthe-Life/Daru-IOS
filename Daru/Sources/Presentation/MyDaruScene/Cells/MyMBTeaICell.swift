//
//  MyMBTeaICell.swift
//  Daru
//
//  Created by 재영신 on 2022/05/24.
//

import UIKit
import SnapKit
import Then

final class MyMBTeaICell: UICollectionViewCell {
    
    static let identifier = "MyMBTeaICell"
    
    private let mbteaiView = UIView().then {
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.brown3?.cgColor
        $0.layer.cornerRadius = 15.0
    }

    private let mbteaiImageView = UIImageView().then {
        $0.image = Constant.rabbitTypeImage
    }

    private let mbteaiLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
        $0.textColor = .tit_brwon
        $0.text = "백차 토끼형"
        $0.textAlignment = .center
    }

    private let mbteaiTagLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.textColor = .gray3
        $0.text = "#백차 #꽃차 #뿌리차"
        $0.textAlignment = .center
    }
    
    private let retryButton = PrimaryButton().then {
        $0.setTitle("다시 검사해보기", for: .normal)
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
            mbteaiView,
            retryButton
        ].forEach {
            contentView.addSubview($0)
        }
        
        [
            mbteaiImageView,
            mbteaiLabel,
            mbteaiTagLabel
        ].forEach {
            mbteaiView.addSubview($0)
        }
        
        mbteaiView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20.0)
            make.top.equalToSuperview()
        }
        
        mbteaiImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(140.0)
            make.top.equalToSuperview().inset(20.0)
        }
        
        mbteaiLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mbteaiImageView.snp.bottom).offset(12.0)
        }
        
        mbteaiTagLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12.0)
            make.top.equalTo(mbteaiLabel.snp.bottom).offset(5.0)
            make.bottom.equalToSuperview().inset(12.0)
        }
        
        retryButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(mbteaiView)
            make.top.equalTo(mbteaiView.snp.bottom).offset(20.0)
        }
    }
}
