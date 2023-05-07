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
      return getBounds().xib()
    }
  
//  func boundsEqual(_ rect: CGRect) -> Bool {
//    return ((self.size.width  == rect.size.width) &&
//            (self.size.height == rect.size.height))
//  }
    
    func getBounds() -> CGRect {
      return CGRect(x: 0, y: 0, width: width, height: height)
    }
      
    var description:String {
      return "\(self.origin.x),\(self.origin.y)_|\(self.width),\(self.height)"
    }
  
}

