

import UIKit

typealias DesignTextFieldValueCallback = (_ text: String) -> ()

@IBDesignable
class DesignTextField: UITextField {

    var textChangeCallback: DesignTextFieldValueCallback?
    
    @IBInspectable var fillColor: UIColor = .clear
    
    @IBInspectable var gradientColor: UIColor?
    @IBInspectable var gradientOffset: CGPoint = CGPoint(x: 0, y: 1)
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    @IBInspectable var shadowColor: UIColor = .clear
    @IBInspectable var shadowOffset: CGSize = CGSize.zero
    @IBInspectable var shadowRadius: CGFloat = 0.0
    @IBInspectable var shadowOpacity: CGFloat = 0.0
    
    @IBInspectable var borderColor: UIColor = .clear
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    @IBInspectable var rightPadding: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        
        if let gradientColor = gradientColor {
            
            let glayer = CAGradientLayer()
            glayer.frame = bounds
            glayer.colors = [fillColor.cgColor, gradientColor.cgColor]
            glayer.startPoint = CGPoint.zero
            glayer.endPoint = gradientOffset
            glayer.cornerRadius = radius()
            layer.insertSublayer(glayer, at: 0)
            
        } else {
            layer.backgroundColor = fillColor.cgColor
        }
        
        layer.cornerRadius     = radius()
        
        layer.shadowOffset     = shadowOffset
        layer.shadowOpacity    = Float(shadowOpacity / 10.0)
        layer.shadowRadius     = shadowRadius
        layer.shadowColor      = shadowColor.cgColor
        
        layer.borderColor      = borderColor.cgColor
        layer.borderWidth      = borderWidth
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
        
        delegate = self
    }
    
    func radius() -> CGFloat {
        let minSize = min(frame.size.width, frame.size.height)
        let radius = ((cornerRadius < 0) ? (minSize / 2) : cornerRadius)
        return radius
    }
    
}

extension DesignTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if let textChangeCallback = textChangeCallback {
            textChangeCallback("")
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text!
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
        
        if let textChangeCallback = textChangeCallback {
            textChangeCallback(newText)
        }
        
        return true
        
//        if var str = textField.text {
//            str.replacingCharacters(in: range, with: string)
//        }
        //str = [str stringByReplacingCharactersInRange:range withString:string];
        
//        return false
    }
    
}
