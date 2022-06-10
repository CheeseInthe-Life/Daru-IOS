//
//  NearTeahouseHeaderView.swift
//  Daru
//
//  Created by 재영신 on 2022/05/30.
//

import UIKit
import SnapKit
import Then

final class TeahouseListHeaderView: UICollectionReusableView {
    
    static let identifier = "\(type(of: self))"
    
    private let titleLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
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
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(18.0)
        }
    }
    
    func update(with title: String) {
        titleLabel.text = title
    }
}
