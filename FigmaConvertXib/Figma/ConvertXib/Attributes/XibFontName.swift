//
//  XibFontName.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 10.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {

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
