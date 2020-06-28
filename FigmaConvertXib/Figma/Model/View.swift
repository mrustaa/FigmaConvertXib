//
//  View.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 26.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class FigmaView {
    
    let id, name: String
    let type: FigmaDocument.Type_
    var subviews: [FigmaView] = []
    
    var blendMode: BlendMode = .modeDefault
    
    var absoluteBoundingBox: CGRect = CGRect.zero
    var realFrame: CGRect = CGRect.zero
    var realRadius: CGFloat = 0.0
    
    var visible: Bool = true
    var clipsContent: Bool = false
    
    var backgroundColor: UIColor = .clear
    var fills: [FigmaFill] = []
    
    var strokeWeight: CGFloat = 0.0
    var strokeColor: UIColor = .clear
    var strokes: [FigmaFill] = []
    
    var cornerRadius: CGFloat = 0.0
    var text: String = ""
    var fontStyle: FigmaFont?
    
    init(_ page: FigmaPage) {
        
        id = page.id
        name = page.name
        type = page.type
        backgroundColor = page.backgroundColor
        realFrame = page.realFrame
        subviews = page.subviews
    }
    
    init(_ dict: [String:Any]) {
        
        id = dString(dict, "id")
        name = dString(dict, "name")
        
        let t = dString(dict, "type")
        type = FigmaDocument.Type_.install(t)
        
        
        if let backgroundColor_ = dDict(dict, "backgroundColor") {
            backgroundColor = FigmaColor.color(backgroundColor_)
        }
        
        if let visible = dict["visible"] as? Bool {
            self.visible = visible
        }
        
        if let arrayFills = dict["fills"] as? [ [String: Any] ] {
            self.fills = []
            for dictFill in arrayFills {
                self.fills.append( FigmaFill(dictFill) )
            }
        }
        
        if let arrayStrokes = dict["strokes"] as? [ [String: Any] ] {
            self.strokes = []
            for dict in arrayStrokes {
                self.strokes.append( FigmaFill(dict) )
            }
            for strokes in arrayStrokes {
                if let color = strokes["color"] as? [String: Any] {
                    self.strokeColor = FigmaColor.color(color)
                }
            }
        }
        
        if let strokeWeight = dict["strokeWeight"] as? CGFloat {
            self.strokeWeight = strokeWeight
        }
        
        if let blendMode = dict["blendMode"] as? String {
            self.blendMode = BlendMode.blendMode(blendMode)
        }
        
        if let absoluteBoundingBox = dict["absoluteBoundingBox"] as? [String: Any] {
            self.absoluteBoundingBox = FigmaFrame.rect(absoluteBoundingBox)
        }
        
        if let clipsContent = dict["clipsContent"] as? Bool {
            self.clipsContent = clipsContent
        }
        
        if let cornerRadius = dict["cornerRadius"] as? CGFloat {
            self.cornerRadius = cornerRadius
        }
        
        if let characters = dict["characters"] as? String {
            self.text = characters
        }
        
        if let style = dict["style"] as? [String: Any] {
            self.fontStyle = FigmaFont(style)
        }
        
        if let arrayPages = dict["children"] as? [ [String: Any] ] {
            subviews = []
            for page in arrayPages {
                subviews.append( FigmaView(page) )
            }
        }
        
    }
}

extension FigmaView {
    
    enum BlendMode: String {
        
        case modeDefault = ""
        
        case color = "COLOR"
        case colorBurn = "COLOR_BURN"
        case colorDodge = "COLOR_DODGE"
        case darken = "DARKEN"
        case difference = "DIFFERENCE"
        case exclusion = "EXCLUSION"
        case hardLight = "HARD_LIGHT"
        case hue = "HUE"
        case lighten = "LIGHTEN"
        case linearBurn = "LINEAR_BURN"
        case linearDodge = "LINEAR_DODGE"
        case luminosity = "LUMINOSITY"
        case multiply = "MULTIPLY"
        case normal = "NORMAL"
        case overlay = "OVERLAY"
        case passThrough = "PASS_THROUGH"
        case saturation = "SATURATION"
        case screen = "SCREEN"
        case softLight = "SOFT_LIGHT"
        
        static func blendMode(_ str: String) -> BlendMode {
            var bMode: BlendMode = .color
            
            switch str {
            case "COLOR": bMode = .color
            case "COLOR_BURN": bMode = .colorBurn
            case "COLOR_DODGE": bMode = .colorDodge
            case "DARKEN": bMode = .darken
            case "DIFFERENCE": bMode = .difference
            case "EXCLUSION": bMode = .exclusion
            case "HARD_LIGHT": bMode = .hardLight
            case "HUE": bMode = .hue
            case "LIGHTEN": bMode = .lighten
            case "LINEAR_BURN": bMode = .linearBurn
            case "LINEAR_DODGE": bMode = .linearDodge
            case "LUMINOSITY": bMode = .luminosity
            case "MULTIPLY": bMode = .multiply
            case "NORMAL": bMode = .normal
            case "OVERLAY": bMode = .overlay
            case "PASS_THROUGH": bMode = .passThrough
            case "SATURATION": bMode = .saturation
            case "SCREEN": bMode = .screen
            case "SOFT_LIGHT": bMode = .softLight
            default: break
            }
            return bMode
        }
    }
}
