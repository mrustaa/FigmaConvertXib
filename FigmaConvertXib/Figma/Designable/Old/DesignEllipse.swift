//
//  DesignEllipse.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 20.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

@IBDesignable
class DesignEllipse: UIView {
    
    //MARK: Fill
    
    @IBInspectable var fillColor: UIColor = .clear
    
    //MARK: Gradient
    
    @IBInspectable var grColor2: UIColor?
    @IBInspectable var grColor3: UIColor?
    @IBInspectable var grColor4: UIColor?
    @IBInspectable var grColor5: UIColor?
    @IBInspectable var grColor6: UIColor?
    
    @IBInspectable var grStartPoint: CGPoint = CGPoint.zero
    @IBInspectable var grEndPoint:   CGPoint = CGPoint.zero
    
    @IBInspectable var grRadial: Bool = false
    
//    //MARK: Inner Shadow
//
//    @IBInspectable var inShColor: UIColor = .clear
//    @IBInspectable var inShRadius: CGFloat = 0.0
//    @IBInspectable var inShOffset: CGSize = CGSize.zero
    
    //MARK: Shadow
    
    @IBInspectable var shColor:  UIColor = .clear
    @IBInspectable var shRadius: CGFloat = 0.0
    @IBInspectable var shOffset: CGSize  = CGSize.zero
    
    //MARK: Border
    
    @IBInspectable var brColor: UIColor = .clear
    @IBInspectable var brWidth: CGFloat = 0.0
    
    //MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        gradient()
        border()
        shadow()
    }
    
    private func border() {
        
        let ellipse = ellipseMask(.clear)
            ellipse.strokeColor = brColor.cgColor
            ellipse.lineWidth = brWidth
        
        layer.addSublayer(ellipse)
    }
    
    private func shadow() {
        layer.shadowOffset     = shOffset
        layer.shadowOpacity    = 1.0
        layer.shadowRadius     = shRadius
        layer.shadowColor      = shColor.cgColor
    }
    
    private func ellipseMask(_ color: UIColor) -> CAShapeLayer {
        
        let ellipsePath = UIBezierPath(ovalIn: bounds)
        
           let mask = CAShapeLayer()
               mask.frame = bounds
               mask.path = ellipsePath.cgPath
               mask.fillColor = color.cgColor
               mask.opacity = 1.0
        return mask
    }
    
    private func gradient() {
        
        var colors: [CGColor] = []
        
        if grColor6 != nil || grColor2 != nil || grColor3 != nil || grColor4 != nil || grColor5 != nil {
            
            colors.append(fillColor.cgColor)
            if let color2 = grColor2 { colors.append(color2.cgColor) }
            if let color3 = grColor3 { colors.append(color3.cgColor) }
            if let color4 = grColor4 { colors.append(color4.cgColor) }
            if let color5 = grColor5 { colors.append(color5.cgColor) }
            if let color6 = grColor6 { colors.append(color6.cgColor) }
            
            let grLayer = CAGradientLayer()
            grLayer.frame = bounds
            grLayer.colors = colors
            grLayer.startPoint = grStartPoint
            grLayer.endPoint   = grEndPoint
            grLayer.mask = ellipseMask(.black)
            
            layer.insertSublayer(grLayer, at: 0)
            
        } else {
            
            let ellipse = ellipseMask(fillColor)
            layer.insertSublayer(ellipse, at: 0)
        }
        
    }
    
    
}
