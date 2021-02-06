//
//  XibFigmaFillGradient.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 20.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension FigmaFill {
    
    func xibGradient() -> String {
        
        var xib = ""

        var i: Int = 0
        for color in gradientStops {
            
            switch i {
            case 0: xib += xibAttr(color: color, key: "grColor1")
            case 1: xib += xibAttr(color: color, key: "grColor2")
            case 2: xib += xibAttr(color: color, key: "grColor3")
            case 3: xib += xibAttr(color: color, key: "grColor4")
            case 4: xib += xibAttr(color: color, key: "grColor5")
            case 5: xib += xibAttr(color: color, key: "grColor6")
            default: break
            }
            
            i += 1
        }
        
        xib += xibAttr(boolean: (type == .gradientRadial), key: "grRadial")
        
        // xib += xibAttr(boolean: true, key: "grPointPercent")
        
        xib += xibAttr(point: startPoint(), key: "grStartPoint")
        xib += xibAttr(point: endPoint(),   key: "grEndPoint")
        
        return xib
    }
    
    
    
    func xibGradientLinear() -> String {
        
        if type != .gradientLinear { return "" }
        
        var xib = ""

        var i: Int = 0
        for color in gradientStops {
            
            switch i {
            case 0: xib += xibAttr(color: color, key: "fillColor")
            case 1: xib += xibAttr(color: color, key: "grColor2")
            case 2: xib += xibAttr(color: color, key: "grColor3")
            case 3: xib += xibAttr(color: color, key: "grColor4")
            case 4: xib += xibAttr(color: color, key: "grColor5")
            case 5: xib += xibAttr(color: color, key: "grColor6")
            default: break
            }
            
            i += 1
        }
        
        xib += xibAttr(point: startPoint(), key: "grStartPoint")
        xib += xibAttr(point: endPoint(),   key: "grEndPoint")
        
        return xib
    }
    
}
