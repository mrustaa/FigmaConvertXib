//
//  XibRect.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 03.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension CGRect {
    
    func xib() -> String {
        return "<rect key=\"frame\" x=\"\(self.origin.x)\" y=\"\(self.origin.y)\" width=\"\(self.size.width)\" height=\"\(self.size.height)\"/>"
    }
    
    func xibBound() -> String {
        let r = CGRect(x: 0, y: 0, width: width, height: height)
        return r.xib()
    }
}

