//
//  Frame.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 28.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class FigmaRect {
    
    class func rect(_ rect: [String: Any]) -> CGRect {
        let x = rect["x"] as! CGFloat
        let y = rect["y"] as! CGFloat
        let w = rect["width"] as! CGFloat
        let h = rect["height"] as! CGFloat
        return CGRect(x: x, y: y, width: w, height: h)
    }
}
