

import UIKit

@IBDesignable
class DesignView: UIView {
    
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
    
    //MARK: Inner Shadow
    
    @IBInspectable var inShColor: UIColor = .clear
    @IBInspectable var inShRadius: CGFloat = 0.0
    @IBInspectable var inShOffset: CGSize = CGSize.zero
    
    //MARK: Shadow
    
    @IBInspectable var shColor: UIColor = .clear
    @IBInspectable var shRadius: CGFloat = 0.0
    @IBInspectable var shOffset: CGSize = CGSize.zero
    
    //MARK: Border
    
    @IBInspectable var brColor: UIColor = .clear
    @IBInspectable var brWidth: CGFloat = 0.0
    
//    @IBInspectable var brGrColor1: UIColor?
//    @IBInspectable var brGrColor2: UIColor?
//    @IBInspectable var brGrStartPoint: CGPoint = CGPoint.zero
//    @IBInspectable var brGrEndPoint:   CGPoint = CGPoint.zero
    
    //MARK: Blur
    
    @IBInspectable var blur: CGFloat = 0.0
    
    //MARK: Radius
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    //MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        
        layer.cornerRadius = self.cornerRadius(cornerRadius)
        
        layer.backgroundColor = fillColor.cgColor
        
        
        addGradient()
        addInnerShadow()
        addShadow()
        addBorder()
        
        add(blur: blur)
    }
    
//    func addBorderGradient() {
//
//        if let brGrColor1 = brGrColor1,
//           let brGrColor2 = brGrColor2 {
//
//            gradientBorder(borderWidth: brWidth,
//                           startColor: brGrColor1,
//                           endColor: brGrColor2,
//                           startPoint: brGrStartPoint,
//                           endPoint: brGrEndPoint,
//                           cornerRadius: self.cornerRadius(cornerRadius))
//        }
//    }
//
//    func gradientBorder(borderWidth: CGFloat,
//                        startColor: UIColor,
//                        endColor: UIColor,
//                        startPoint: CGPoint,
//                        endPoint: CGPoint,
//                        cornerRadius: CGFloat) {
//
//        let gr: UIView = UIView(frame: bounds)
//        gr.backgroundColor = .clear
//
//        let gradient = CAGradientLayer()
//        gradient.colors = [startColor.cgColor, endColor.cgColor]
//        gradient.startPoint = startPoint
//        gradient.endPoint = endPoint
//        gradient.frame = self.bounds
//        layer.addSublayer(gradient)
////        layer.insertSublayer(gradient, at: 0)
//        self.mask = gr
//
//        gr.layer.cornerRadius = cornerRadius
//        gr.layer.borderWidth = borderWidth
//
//        layer.borderWidth = 0
//    }
    
    private func addGradient() {
        
        _ = add(gradient: fillColor,
                color2: grColor2,
                color3: grColor3,
                color4: grColor4,
                color5: grColor5,
                color6: grColor6,
            pointStart: grStartPoint,
            pointEnd:   grEndPoint,
            cornerRadius: cornerRadius)
        
    }
    
    private func addInnerShadow() {
        
        addInnerShadow(color: inShColor.cgColor,
                       radius: inShRadius,
                       offset: inShOffset,
                       cornerRadius: cornerRadius)
        
    }
    
    private func addShadow() {
        layer.shadowOffset     = shOffset
        layer.shadowOpacity    = 1.0
        layer.shadowRadius     = shRadius
        layer.shadowColor      = shColor.cgColor
    }
    
    private func addBorder() {
        layer.borderColor      = brColor.cgColor
        layer.borderWidth      = brWidth
    }
    
}
