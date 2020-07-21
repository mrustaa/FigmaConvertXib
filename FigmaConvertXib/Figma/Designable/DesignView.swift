

import UIKit

@IBDesignable
class DesignView: UIView {
    
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
    
    
    //MARK: - Border
    
    @IBInspectable var borderColor: UIColor = .clear
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    //MARK: - Blur
    
    @IBInspectable var blur: CGFloat = 0.0
    
    //MARK: - Radius
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        
        layer.cornerRadius = self.cornerRadius(cornerRadius)
        
        layer.backgroundColor = fillColor.cgColor
        
        addGradient()
        addInnerShadow()
        addShadow()
        addBorder()
        
        add(blur: blur)
    }
    
    private func addGradient() {
        
        _ = add(gradient: fillColor,
            color1: gradientColor,
            color2: gradientColor2,
            color3: gradientColor3,
            pointStart: gradientStartPoint,
            pointEnd: gradientOffset,
            cornerRadius: cornerRadius)
        
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
    
}
