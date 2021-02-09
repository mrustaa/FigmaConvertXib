//
//  XmlImage.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 18.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation



extension FigmaFill {
    
    func scaleType() -> String {
        return (scaleMode == .fill) ? "centerCrop" : "fitCenter"
    }
    
}

extension FigmaNode {
    
    func xmlImageCompnent() -> String {
        
        return  """
                
                android:scaleType="centerCrop"
                android:src="@drawable/\(name.xmlFilter())"
            """
    }
    
    func xmlImage() -> String {
        
        var attrs = ""
        
        if let imgFill = xibSearch(fill: .image) {
            
            attrs += """
                
                android:scaleType="\(imgFill.scaleType())"
                android:src="@drawable/\(name.xmlFilter())"
            """
        }
        return attrs
    }
    
}
