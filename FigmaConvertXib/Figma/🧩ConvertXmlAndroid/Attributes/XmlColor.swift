//
//  XmlColor.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 18.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaNode {
    
    func xmlColor() -> String {
        
        var attrs = ""

        if let fill = xibSearch(fill: .solid) {
            
            let hex = fill.colorA().hex()
            
            var keyValue = "background"
            if type == .text {
                keyValue = "textColor"
            }
            
            attrs += """
            
                android:\(keyValue)="\(hex)"
            """
        }
        return attrs
    }
    
}
    

