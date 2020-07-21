//
//  FigmaBlendMode.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 15.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

extension FigmaNode {
    
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
        
        static func install(_ str: String) -> BlendMode {
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
