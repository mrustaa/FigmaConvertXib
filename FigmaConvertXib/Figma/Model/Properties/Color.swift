//
//  Color.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 26.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class F_Color {
    
    class func rgba( _ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    
    class func color(_ color: [String: Any]) -> UIColor {
        let r = color["r"] as! CGFloat
        let g = color["g"] as! CGFloat
        let b = color["b"] as! CGFloat
        let a = color["a"] as! CGFloat
        return rgba(r * 255.0, g * 255.0, b * 255.0, a)
    }
}
