//
//  Color.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 02.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension UIColor {
    
    private var red_:   CGFloat{ return CIColor(color: self).red   }
    private var green_: CGFloat{ return CIColor(color: self).green }
    private var blue_:  CGFloat{ return CIColor(color: self).blue  }
    private var alpha_: CGFloat{ return CIColor(color: self).alpha }
    
    func xib(_ key: String = "value") -> String {
        return "<color key=\"\(key)\" red=\"\(self.red_)\" green=\"\(self.green_)\" blue=\"\(self.blue_)\" alpha=\"\(self.alpha_)\" colorSpace=\"custom\" customColorSpace=\"sRGB\"/>"
    }
    
}
