//
//  XibFontName.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 10.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {

    func fontBold() -> Bool {
        
        if type == .text, let pageFont = fontStyle, let name = pageFont.fontPostScriptName {

            if name.contains("Bold") || name.contains("bold") || name.contains("Semibold") || name.contains("semibold") || name.contains("Medium") || name.contains("medium")  ||  name.contains("Light") || name.contains("light") {
                return true
            }
        }
        return false
    }
    
    
    
    func fontSize() -> CGFloat {
        
        if type == .text, let pageFont = fontStyle {
            return pageFont.fontSize
        } else {
            return 0.0
        }
    }
    
    
    func fontItalic() -> Bool {
        
        if type == .text, let pageFont = fontStyle {
            return pageFont.italic
        } else {
            return false
        }
    }
    
    func fontNameXib() -> String {
        
        var xmlFontDescription = ""
        
        if type == .text, let pageFont = fontStyle {
            
            var findFont: UIFont?
            var fontSize: CGFloat = 0.0
            
            fontSize = pageFont.fontSize
            
            if let fontName = pageFont.fontPostScriptName {
                        
                if let font = UIFont(name: fontName, size: pageFont.fontSize) {
                    findFont = font
                } else {
                    if let font = UIFont(name: "\(fontName)-Regular", size: pageFont.fontSize) {
                        findFont = font
                    }
                }
            }
            
            if findFont != nil {
                xmlFontDescription = "<fontDescription key=\"fontDescription\" name=\"\(findFont!.fontName)\" family=\"\(findFont!.familyName)\" pointSize=\"\(fontSize)\"/>"
                
            } else {
                if let fontPostScriptName = pageFont.fontPostScriptName {
                    xmlFontDescription = "<fontDescription key=\"fontDescription\" type=\"system\" pointSize=\"\(fontSize)\"/>"
                    
                    // if fontPostScriptName.contains("Regular") || fontPostScriptName.contains("regular") {
                    // xmlFontDescription = "\n\(tabs)\(tabsString(level: 0))<fontDescription key=\"fontDescription\" type=\"system\" pointSize=\"\(fontSize)\"/>"
                    // } else
                    
                    if fontPostScriptName.contains("Bold") || fontPostScriptName.contains("bold") {
                        xmlFontDescription = "<fontDescription key=\"fontDescription\" type=\"boldSystem\" pointSize=\"\(fontSize)\"/>"
                    } else if fontPostScriptName.contains("Semibold") || fontPostScriptName.contains("semibold") {
                        xmlFontDescription = "<fontDescription key=\"fontDescription\" type=\"system\" weight=\"semibold\" pointSize=\"\(fontSize)\"/>"
                    } else if fontPostScriptName.contains("Medium") || fontPostScriptName.contains("medium") {
                        xmlFontDescription = "<fontDescription key=\"fontDescription\" type=\"system\" weight=\"medium\" pointSize=\"\(fontSize)\"/>"
                    } else if fontPostScriptName.contains("Light") || fontPostScriptName.contains("light") {
                        xmlFontDescription = "<fontDescription key=\"fontDescription\" type=\"system\" weight=\"light\" pointSize=\"\(fontSize)\"/>"
                    }
                } else {
                    xmlFontDescription = "<fontDescription key=\"fontDescription\" type=\"system\" pointSize=\"\(fontSize)\"/>"
                }
            }
        }
        return xmlFontDescription
    }

}
