//
//  Font.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 28.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class FigmaFont {
    
    var fontFamily: String = ""
    var fontPostScriptName: String?
    var italic: Bool = false
    var fontSize: CGFloat = 0.0
    var fontWeight: CGFloat = 0.0
    var letterSpacing: CGFloat = 0.0
    var lineHeightPercent: CGFloat = 0.0
    var lineHeightPx: CGFloat = 0.0
    var textAlignHorizontal: AlignHorizontal = .left
    var textAlignVertical: AlignVertical = .center
    
    init(_ dict: [String:Any]) {
        
        if let fontFamily = dict["fontFamily"] as? String {
            self.fontFamily = fontFamily
        }
        if let fontPostScriptName = dict["fontPostScriptName"] as? String {
            self.fontPostScriptName = fontPostScriptName
        }
        if let italic = dict["italic"] as? Bool {
            self.italic = italic
        }
        if let fontSize = dict["fontSize"] as? CGFloat {
            self.fontSize = fontSize
        }
        if let fontWeight = dict["fontWeight"] as? CGFloat {
            self.fontWeight = fontWeight
        }
        if let letterSpacing = dict["letterSpacing"] as? CGFloat {
            self.letterSpacing = letterSpacing
        }
        if let lineHeightPercent = dict["lineHeightPercent"] as? CGFloat {
            self.lineHeightPercent = lineHeightPercent
        }
        if let lineHeightPercent = dict["lineHeightPercent"] as? CGFloat {
            self.lineHeightPercent = lineHeightPercent
        }
        
        if let textAlignHorizontal = dict["textAlignHorizontal"] as? String {
            self.textAlignHorizontal = AlignHorizontal.type(textAlignHorizontal)
        }
        if let textAlignVertical = dict["textAlignVertical"] as? String {
            self.textAlignVertical = AlignVertical.type(textAlignVertical)
        }
    }
}

extension FigmaFont {
    
    enum AlignHorizontal: String {
        
        case center = "CENTER"
        case justified = "JUSTIFIED"
        case left = "LEFT"
        case right = "RIGHT"
        
        static func type(_ str: String) -> AlignHorizontal {
            var type: AlignHorizontal = .left
            
            switch str {
            case "CENTER": type = .center
            case "JUSTIFIED": type = .justified
            case "LEFT": type = .left
            case "RIGHT": type = .right
            default: break
            }
            return type
        }
    }
}

extension FigmaFont {
    
    enum AlignVertical: String {
        
        case bottom = "BOTTOM"
        case center = "CENTER"
        case top = "TOP"
        
        static func type(_ str: String) -> AlignVertical {
            var type: AlignVertical = .center
            
            switch str {
            case "BOTTOM": type = .bottom
            case "CENTER": type = .center
            case "TOP": type = .top
            default: break
            }
            return type
        }
    }
}






