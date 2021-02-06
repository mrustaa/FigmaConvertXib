//
//  XibCornerRadius.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 20.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {
    
    func xibCornerRadius() -> String {
        
        if realRadius == 0 { return "" }
        
        return xibAttr(number: realRadius, key: "cornerRadius")
    }
    
}
