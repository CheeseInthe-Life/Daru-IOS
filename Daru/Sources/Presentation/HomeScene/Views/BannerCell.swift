//
//  BannerCell.swift
//  Daru
//
//  Created by 재영신 on 2022/05/17.
//

import UIKit
import SnapKit
import Then
import ImageSlideshow

final class BannerCell: UICollectionViewCell {
    
    static let identifier = "BannerCell"
    
    private let imageSlide = ImageSlideshow().then {
        $0.zoomEnabled = false
        $0.circular = true
        $0.slideshowInterval = 10.0
        $0.pageIndicator = nil
    }
    
    private let pageIndicator = UIPageControl().then {
        $0.currentPageIndicatorTintColor = UIColor(hex: "#C2A88F")
        $0.pageIndicatorTintColor = UIColor(hex: "#F3E8DE")
        $0.isUserInteractionEnabled = false
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
            imageSlide,
            pageIndicator
        ].forEach {
            contentView.addSubview($0)
        }
        
        imageSlide.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(24.0)
            make.leading.trailing.equalToSuperview().inset(20.0)
        }
        
        pageIndicator.snp.makeConstraints { make in
            make.top.equalTo(imageSlide.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
    }
    
    //TODO: UIImage -> URL
    func update(with images: [UIImage]) {
        imageSlide.setImageInputs(images.map{ ImageSource(image: $0) })
        pageIndicator.numberOfPages = images.count
        imageSlide.currentPageChanged = {
            [weak self] page in
            self?.pageIndicator.page = page
        }
    }
}
