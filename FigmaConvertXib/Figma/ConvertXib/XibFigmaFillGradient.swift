//
//  XibFigmaFillGradient.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 20.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension FigmaFill {
    
    func xibGradientLinear() -> String {
        
        if type != .gradientLinear { return "" }
        
        var xibColors = ""
        var xibPoints = ""
        
        var index: Int = 0
        for color in gradientStops {
            
            var keyPath = "gradientColor3"
            if index == 0 {
                keyPath = "fillColor"
            } else if index == 1 {
                keyPath = "gradientColor"
            } else if index == 2 {
                keyPath = "gradientColor2"
            } else if index == 3 {
                keyPath = "gradientColor3"
            }
            
            xibColors = xibColors
                + xibAttr(color: color, key: keyPath)
            
            index += 1
        }
        
        let pointFirst: CGPoint = gradientHandlePositions[0]
        let pointLast: CGPoint = gradientHandlePositions[gradientHandlePositions.count - 2]
        
        xibPoints =
            xibAttr(point: pointFirst, key: "gradientStartPoint")
            + xibAttr(point: pointLast, key: "gradientOffset")
        
        return "\(xibColors)\(xibPoints)"
    }
    
}
