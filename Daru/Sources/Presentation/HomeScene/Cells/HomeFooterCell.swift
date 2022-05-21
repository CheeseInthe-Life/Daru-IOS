//
//  HomeFooterCell.swift
//  Daru
//
//  Created by 재영신 on 2022/05/21.
//

import UIKit
import SnapKit
import Then

final class HomeFooterCell: UICollectionViewCell {
    
    static let identifier = "HomeFooterCell"
    
    private let companyNameLabel = UILabel().then {
        $0.font = .nanumGothic(.regular, size: 14.0)
        $0.text = "회사 이름"
        $0.textColor = .gray2
    }
    
    private let addressLabel = UILabel().then {
        $0.font = .nanumGothic(.regular, size: 14.0)
        $0.text = "주소 : 서울특뱔시 양천구 신정로7길 75"
        $0.textColor = .gray2
    }
    
    private let mailOrderNumberLabel = UILabel().then {
        $0.font = .nanumGothic(.regular, size: 14.0)
        $0.text = "통신판매번호 : 2020-서울송파-3147"
        $0.textColor = .gray2
    }
    
    private let businessNumberLabel = UILabel().then {
        $0.font = .nanumGothic(.regular, size: 14.0)
        $0.text = "사업자 등록번호 : 174-88-01588"
        $0.textColor = .gray2
    }
    
    private let representativeNumberLabel = UILabel().then {
        $0.font = .nanumGothic(.regular, size: 14.0)
        $0.text = "대표번호 : 02-6959-9635"
        $0.textColor = .gray2
    }
    
    private let copyrightLabel = UILabel().then {
        $0.font = .nanumGothic(.regular, size: 14.0)
        $0.text = "Copyright © 2021 humtouchlab. All rights reserved"
        $0.textColor = .gray2
    }
    
    private let infoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
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
            companyNameLabel,
            addressLabel,
            mailOrderNumberLabel,
            businessNumberLabel,
            representativeNumberLabel
        ].forEach {
            infoStackView.addArrangedSubview($0)
        }
        
        [
            infoStackView,
            copyrightLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        contentView.backgroundColor = .gray7
        
        copyrightLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(infoStackView)
            make.bottom.equalToSuperview().inset(20.0)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(20.0)
            make.bottom.equalTo(copyrightLabel.snp.top).offset(-10.0)
        }
    
    }
}
