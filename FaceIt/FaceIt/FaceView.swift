//
//  FaceView.swift
//  FaceIt
//
//  Created by 조성지 on 2020/05/27.
//  Copyright © 2020 조성지. All rights reserved.
//

import UIKit

class FaceView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let skullRadius = min(bounds.size.width, bounds.size.height)/2
        let skullCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        // var skullCenter = convert(center, from: superview)
        
        let skull = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0.0, endAngle: 2*CGFloat(Double.pi), clockwise: false)
        skull.lineWidth = 5.0
        UIColor.blue.set()
        skull.stroke()
    }
    
}
