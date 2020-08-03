//
//  FigmaEffectType.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 15.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

extension FigmaEffect {
    
    enum Type_: String {
        case innerShadow = "INNER_SHADOW"
        case dropShadow = "DROP_SHADOW"
        case layerBlur = "LAYER_BLUR"
        case backgroundBlur = "BACKGROUND_BLUR"
        
        static func install(_ str: String) -> Type_ {
            var nType: Type_ = .dropShadow
            switch str {
                case "INNER_SHADOW": nType = .innerShadow
                case "DROP_SHADOW": nType = .dropShadow
                case "LAYER_BLUR": nType = .layerBlur
                case "BACKGROUND_BLUR": nType = .backgroundBlur
                default: break
            }
            return nType
        }
    }
}
