//
//  PostCommentHeaderView.swift
//  Daru
//
//  Created by 재영신 on 2022/06/09.
//

import UIKit
import SnapKit
import Then

final class PostCommentHeaderView: UICollectionReusableView {
    
    static let identifier = "\(PostCommentHeaderView.self)"
    
    private let prefixLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
        $0.textColor = .tit_brwon
        $0.text = "댓글"
    }
    
    private let commentCountLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
        $0.textColor = .brown3
        $0.text = "(3)"
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
            prefixLabel,
            commentCountLabel
        ].forEach {
            addSubview($0)
        }
        
        prefixLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20.0)
            make.top.equalToSuperview().inset(18.0)
            make.bottom.equalToSuperview().inset(10.0)
        }
        
        commentCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(prefixLabel.snp.trailing)
            make.top.bottom.equalTo(prefixLabel)
        }
    }
}
