//
//  Frame.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 28.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class FigmaFrame {
    
    class func rect(_ rect: [String: Any]) -> CGRect {
        let x = rect["x"] as! CGFloat
        let y = rect["y"] as! CGFloat
        let w = rect["width"] as! CGFloat
        let h = rect["height"] as! CGFloat
        return CGRect(x: x, y: y, width: w, height: h)
    }
}

class FigmaOffset {
    
    class func install(_ dict: [String: Any]) -> CGSize {
        let x = dict["x"] as! CGFloat
        let y = dict["y"] as! CGFloat
        return CGSize(width: x, height: y)
    }
}
