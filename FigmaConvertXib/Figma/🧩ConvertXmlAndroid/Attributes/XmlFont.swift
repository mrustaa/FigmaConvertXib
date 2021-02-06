//
//  XmlFont.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 18.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaNode {
    
    func xmlText() -> String {
        
        var attrs = ""
        
        if type == .text {
            
            attrs += xmlTextSizeContent()
            attrs += xmlAlignment()
            attrs += xmlTextStyle()
            
        }
        
        return attrs
    }
    
    func xmlTextSizeContent() -> String {
        
        return """
            
            android:text="\(text.xibFilter())"
            android:textSize="\(fontSize())sp"
        """
        
    }
    
    func xmlAlignment() -> String {
        
        var attrs = ""
        
        if let fontStyle = fontStyle {
            
            var alignment = "textStart"
            switch fontStyle.textAlignHorizontal {
            case .left: alignment = "textStart"
            case .center: alignment = "center"
            case .right: alignment = "textEnd"
            default: break
            }
            
            attrs = """
            
                android:textAlignment="\(alignment)"
            """
        }
        return attrs
    }
    
    func xmlTextStyle() -> String {
        
        var attrs = ""
        
        var textStyle = ""
        if fontBold() && fontItalic() {
            textStyle += "bold|italic"
        } else if fontBold() {
            textStyle += "bold"
        } else if fontItalic() {
            textStyle += "italic"
        }
        
        if !textStyle.isEmpty {
            attrs = """
            
                android:textStyle="\(textStyle)"
            """
        }
        
        return attrs
    }
}
