//
//  TeahouseDetailHeaderView.swift
//  Daru
//
//  Created by 재영신 on 2022/07/05.
//

import UIKit
import SnapKit
import Then

final class TeahouseDetailHeaderView: UICollectionReusableView {
    
    static let identifier = "\(type(of: TeahouseDetailHeaderView.self))"
    
    private let titleLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
        $0.textColor = .tit_brwon
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10.0)
        }
    }
    
    func update(with title: String) {
        titleLabel.text = title
    }
}
