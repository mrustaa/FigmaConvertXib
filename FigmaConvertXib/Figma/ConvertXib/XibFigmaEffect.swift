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
        
        if type == .dropShadow {
            
            return """
            \(xibAttr(color: color, key: "shadowColor"))
            \(xibAttr(number: radius / 2, key: "shadowRadius"))
            \(xibAttr(size: offset, key: "shadowOffset"))
            """
            
        } else if type == .innerShadow {
            
            return """
            \(xibAttr(color: color, key: "innerShColor"))
            \(xibAttr(number: radius / 2, key: "innerShRadius"))
            \(xibAttr(size: offset, key: "innerShOffset"))
            """
            
        } else if type == .layerBlur {
            
            return """
            \(xibAttr(number: radius / 2, key: "blur"))
            """
            
        }
        
        return ""
    }
}

extension FigmaNode {
    
    func xibSearchEffect(type: FigmaEffect.Type_) -> FigmaEffect? {
        for effect: FigmaEffect in effects {
            if effect.type == type {
                return effect
            }
        }
        return nil
    }
    
}
