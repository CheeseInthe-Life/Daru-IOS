//
//  RecentPostCell.swift
//  Daru
//
//  Created by 재영신 on 2022/05/18.
//

import UIKit
import SnapKit
import Then

final class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"
    
    private let writerImageView = UIImageView().then {
        $0.image = Constant.profileDefaultImage
        $0.contentMode = .scaleAspectFit
    }
    
    private let writerNameLabel = UILabel().then {
        $0.font = .notoSansKR(.medium, size: 16.0)
        $0.text = "작성자 이름"
    }
    
    private let creationTimeLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 16.0)
        $0.text = "1분 전"
        $0.textColor = .yellowGreen2
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .notoSansKR(.medium, size: 16.0)
        $0.text = "제목제목제목제목제목"
        $0.numberOfLines = 1
    }
    
    private let contentLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 12.0)
        $0.textColor = .gray3
        $0.text = """
                    본문본문본문본문본문본문본문본문본문본문본문본문본문본문본본문본문본문본문본문본문본문본문본문본문 본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문
                    """
        $0.numberOfLines = 0
    }
    
    private let likeImageView = UIImageView().then {
        $0.image = Constant.likeIcon
    }
    
    private let likeCountLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.textColor = .gray3
        $0.text = "123"
    }
    
    private let commentImageView = UIImageView().then {
        $0.image = Constant.commentIcon
    }
    
    private let commentCountLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.textColor = .gray3
        $0.contentMode = .scaleAspectFit
        $0.text = "2321"
    }
    
    private let scrapImageView = UIImageView().then {
        $0.image = Constant.scrapIcon
    }
    
    private let scrapCountLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.textColor = .gray3
        $0.text = "111"
    }
    
    private let dividingLine = UIView().then {
        $0.backgroundColor = .brown3
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
            writerImageView,
            writerNameLabel,
            creationTimeLabel,
            titleLabel,
            contentLabel,
            dividingLine,
            likeImageView,
            likeCountLabel,
            commentImageView,
            commentCountLabel,
            scrapImageView,
            scrapCountLabel
        ].forEach{
            contentView.addSubview($0)
        }
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.brown3?.cgColor
        contentView.layer.cornerRadius = 12.0
        
        writerImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15.0)
            make.top.equalToSuperview().inset(10.0)
            make.width.height.equalTo(40.0)
        }
        
        writerNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(writerImageView.snp.trailing).offset(10.0)
            make.centerY.equalTo(writerImageView)
        }
        
        creationTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(writerNameLabel.snp.trailing).offset(10.0)
            make.trailing.lessThanOrEqualToSuperview().inset(15.0)
            make.centerY.equalTo(writerImageView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(writerImageView)
            make.top.equalTo(writerImageView.snp.bottom).offset(10.0)
            make.trailing.equalToSuperview().inset(15.0)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5.0)
            make.trailing.equalToSuperview().inset(15.0)
        }
        
        contentLabel.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        contentLabel.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
        
        dividingLine.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10.0)
            make.leading.trailing.equalToSuperview().inset(15.0)
            make.height.equalTo(1.0)
        }
            
        likeImageView.snp.makeConstraints { make in
            make.top.equalTo(dividingLine.snp.bottom).offset(10.0)
            make.leading.equalToSuperview().inset(24.0)
            make.bottom.equalToSuperview().inset(23.0)
        }
        
        likeCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeImageView)
            make.leading.equalTo(likeImageView.snp.trailing).offset(6.0)
        }

        scrapCountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(23.0)
            make.centerY.equalTo(scrapImageView)
        }
        
        scrapImageView.snp.makeConstraints { make in
            make.trailing.equalTo(scrapCountLabel.snp.leading).offset(-6.0)
            make.top.bottom.equalTo(likeImageView)
        }
        
        
        commentCountLabel.snp.makeConstraints { make in
            make.trailing.equalTo(scrapImageView.snp.leading).offset(-37.0)
            make.centerY.equalTo(commentImageView)
        }
        
        commentImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(likeImageView)
            make.trailing.equalTo(commentCountLabel.snp.leading).offset(-6.0)
        }
        

    }
    
}
