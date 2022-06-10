//
//  MyFavoriteFooterView.swift
//  Daru
//
//  Created by 재영신 on 2022/05/24.
//

import UIKit
import SnapKit
import Then

final class MyFavoriteTeaFooterView: UICollectionReusableView {
    
    static let identifier = "MyFavoriteTeaFooterView"
    
    private let editButton = PrimaryButton().then {
        $0.setTitle("편집하기", for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        
        addSubview(editButton)
        
        editButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
