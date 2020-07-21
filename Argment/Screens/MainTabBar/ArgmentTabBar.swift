//
//  ArgmentTabBar.swift
//  Argment
//
//  Created by hladek on 17/07/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ArgmentTabBar: UITabBar {
    private var shapeLayer: CALayer?
    
    @IBInspectable var height: CGFloat = 0.0

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            sizeThatFits.height = height
        }
        return sizeThatFits
    }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.black.cgColor
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    func createPath() -> CGPath {
        let buttonSize: CGFloat = 64
        let depth: CGFloat = buttonSize / 2 + 12
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - buttonSize * 0.86), y: 0)) 
        
        path.addCurve(to: CGPoint(x: centerWidth, y: depth),
                      controlPoint1: CGPoint(x: (centerWidth - (buttonSize * 0.5)), y: 0),
                      controlPoint2: CGPoint(x: (centerWidth - (buttonSize * 0.6)), y: depth))
        path.addCurve(to: CGPoint(x: (centerWidth + buttonSize * 0.825), y: 0),
                      controlPoint1: CGPoint(x: (centerWidth + (buttonSize * 0.6)), y: depth),
                      controlPoint2: CGPoint(x: (centerWidth + (buttonSize * 0.5)), y: 0))
       
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()

        return path.cgPath
    }
}
