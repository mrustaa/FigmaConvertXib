//
//  FigmaEffect.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 20.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension FigmaEffect {
    
    func xib() -> String {
        
        let c = color
        let r = radius / 2
        let o = offset
        
        if type == .dropShadow {
            
            return xibAttr(color:  c, key: "shColor" ) +
                   xibAttr(number: r, key: "shRadius") +
                   xibAttr(size:   o, key: "shOffset")
            
        } else if type == .innerShadow {
            
            return xibAttr(color:  c, key: "inShColor" ) +
                   xibAttr(number: r, key: "inShRadius") +
                   xibAttr(size:   o, key: "inShOffset")
            
        } else if type == .layerBlur {
            
            return xibAttr(number: r, key: "blur")
            
        }
        
        return ""
    }
}


