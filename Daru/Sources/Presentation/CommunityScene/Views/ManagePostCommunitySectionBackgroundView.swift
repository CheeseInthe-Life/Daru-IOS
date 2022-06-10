//
//  ManagePoseCommunitySectionBackgroundView.swift
//  Daru
//
//  Created by 재영신 on 2022/05/27.
//

import UIKit
import SnapKit
import Then

final class ManagePostCommunitySectionBackgroundView: UICollectionReusableView {
    
    static let identifier = "ManagePostCommunitySectionBackgroundView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        backgroundColor = .gray7?.withAlphaComponent(0.7)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.gray5?.cgColor
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX + 20.0, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.maxX - 20.0, y: bounds.midY))
        path.move(to: CGPoint(x: bounds.midX, y: bounds.minY + 20.0))
        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY - 20.0))
        path.move(to: CGPoint(x: bounds.midX, y: bounds.midY + 20.0))
        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY - 20.0))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 3.0
        shapeLayer.strokeColor = UIColor.gray5?.cgColor
        shapeLayer.lineDashPattern = [3,3]
        layer.addSublayer(shapeLayer)
        
    }
    
}
