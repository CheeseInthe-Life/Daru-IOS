//
//  UnderLineLabel.swift
//  Daru
//
//  Created by 재영신 on 2022/05/23.
//

import UIKit

class UnderLineLabel: UILabel {
    
    private var color: UIColor = .gray
    
    private var weight: Double = 1.0
    
    init(color: UIColor, weight: Double) {
        super.init(frame: .zero)
        self.color = color
        self.weight = weight
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 5.0, y: bounds.size.height - (weight / 2.0)))
        path.addLine(to: CGPoint(x: bounds.width - 5.0, y: bounds.size.height - (weight / 2.0)))
        path.lineWidth = weight
        path.lineCapStyle = .round
        color.set()
        path.stroke()
        super.draw(rect)
    }
}
