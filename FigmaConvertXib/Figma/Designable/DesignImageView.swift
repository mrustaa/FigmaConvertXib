//
//  DesignImageView.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 21.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

@IBDesignable
class DesignImageView: UIView {
    
//    @IBInspectable var imageName: String = ""
    @IBInspectable var image: UIImage?
    @IBInspectable var contModeFill: Bool = false
    
    //MARK: - Fill
    
    
    @IBInspectable var fillColor: UIColor = .clear
    
    //MARK: - Gradient
    
    @IBInspectable var gradientColor: UIColor?
    @IBInspectable var gradientColor2: UIColor?
    @IBInspectable var gradientColor3: UIColor?
    @IBInspectable var gradientStartPoint: CGPoint = CGPoint.zero
    @IBInspectable var gradientOffset: CGPoint = CGPoint(x: 0, y: 1)
    
    //MARK: - InnerShadow
    
    @IBInspectable var innerShColor: UIColor = .clear
    @IBInspectable var innerShRadius: CGFloat = 0.0
    @IBInspectable var innerShOffset: CGSize = CGSize.zero
    
    //MARK: - Shadow
    
    @IBInspectable var shadowColor: UIColor = .clear
    @IBInspectable var shadowRadius: CGFloat = 0.0
    @IBInspectable var shadowOffset: CGSize = CGSize.zero
    //MARK: - Radius
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    //MARK: - Border
    
    @IBInspectable var borderColor: UIColor = .clear
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    //MARK: - Blur
    
    @IBInspectable var blur: CGFloat = 0.0
    
    var imageView: UIImageView!
    
    override func draw(_ rect: CGRect) {
        
        let radius = self.cornerRadius(cornerRadius)
        
        layer.cornerRadius = radius
        
        layer.backgroundColor = fillColor.cgColor
        
        addShadow()
        addBorder()
        
        addImage()
        
        addGradient()
        addInnerShadow()
        
        add(blur: blur) { [weak self] in
            guard let _self = self else { return }
            _self.imageView.alpha = 0
        }
        
    }
    
    private func addGradient() {
        
        guard let glayer = add(gradient: fillColor,
            color1: gradientColor,
            color2: gradientColor2,
            color3: gradientColor3,
            pointStart: gradientStartPoint,
            pointEnd: gradientOffset,
            cornerRadius: cornerRadius) else { return }
        
        imageView.layer.insertSublayer(glayer, at: 0)
        
    }
    
    private func addInnerShadow() {
        
        addInnerShadow(color: innerShColor.cgColor,
                       radius: innerShRadius,
                       offset: innerShOffset,
                       cornerRadius: cornerRadius)
        
    }
    
    private func addShadow() {
        layer.shadowOffset     = shadowOffset
        layer.shadowOpacity    = 1.0
        layer.shadowRadius     = shadowRadius
        layer.shadowColor      = shadowColor.cgColor
    }
    
    private func addBorder() {
        layer.borderColor      = borderColor.cgColor
        layer.borderWidth      = borderWidth
    }
    
    
    private func addImage() {
        
        let f = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        imageView = UIImageView(frame: f)
        
//        let image = UIImage(named: imageName, in: Bundle(for: type(of:self)), compatibleWith: nil)
        
        imageView.image = image
        imageView.contentMode = contModeFill ? .scaleAspectFill : .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = self.cornerRadius(cornerRadius)
//        addSubview(imageView)
        
        insertSubview(imageView, at: 0)
    }
    
    private func addLabel() {
        
        let tag = 123
        let fr = CGRect(x: 0, y: 0, width: frame.width / 2, height: frame.height / 2)

        if let label = viewWithTag(tag) as? UILabel {

            label.frame = fr
            label.text = "1"
            return

        } else {

            let label = UILabel.init(frame: fr)
            label.tag = tag
            label.text = Bundle.main.resourcePath
            label.numberOfLines = 10
            label.font = UIFont.boldSystemFont(ofSize: 10.0)
            addSubview(label)
        }
    }
            
    
    
}
